# TODO: bunch of fields i am not using so have not implemented
#   aspect ratio
#   language(s)
#   color
#   certification
#   filming locations
#   country
#   trivia
#   goofs
#   quotes
#   creator
#   seasons
#   awards
#   company
#   contact

module Imdb
  def self.find(id)
    page = Hpricot(open("http://www.imdb.com/title/tt#{id}"))
    headers = (page / 'h5').to_a
    if headers.any?{|h| h.inner_text == 'TV Series:'}
      Episode.new(id, page)
    elsif headers.any?{|h| h.inner_text == 'Seasons:'}
      Series.new(id, page)
    else
      Movie.new(id, page)
    end
  end

  class Base
    attr_accessor :id

    def initialize(id, page)
      @id   = id
      @page = page
    end

    def to_s
      title
    end

    def title;      @title      ||= parse_title;      end
    def rating;     @rating     ||= parse_rating;     end
    def genres;     @genres     ||= parse_genres;     end
    def poster_url; @poster_url ||= parse_poster_url; end
    def runtime;    @runtime    ||= parse_runtime;    end

    # TODO: implement FULL which will hit /title/tt#{id}/cast
    def cast(full = false); @cast ||= parse_cast; end

    # TODO: implement FULL which will hit /title/tt#{id}/plot
    def plot(full = false); @plot ||= parse_plot; end

    # TODO: implement FULL which will hit /title/tt#{id}/plot_keywords
    def keywords(full = false); @keywords ||= parse_keywords; end

    protected
      def page
        @page ||= Hpricot(open("http://www.imdb.com/title/tt#{id}"))
      end

      def parse_title
        page.at("meta[@name='title']")['content'].sub(/\(\d\d\d\d(?:\/\w+)?\)/,'').strip
      end

      def parse_year
        page.at("meta[@name='title']")['content'].sub(/^.+(\d{4}).+$/, '\1').to_i
      end

      def parse_rating
        rating_text = (page/'div.rating/div.meta/b').inner_text
        rating_text =~ /([\d\.]+)\/10/ ? ($1.to_f * 10).to_i : nil
      end

      def parse_poster_url
        page.at("div.photo/a[@name='poster']/img")['src'] rescue nil
      end

      def parse_writers
        container = info_div('Writers')
        (container/'a').map{|a| Person.new(a.inner_text)}.reject{|w| w.to_s == 'more'}
      end

      def parse_cast
        container = (page/'table.cast')
        (container/'tr').map do |row|
          if values = row.inner_text.split(' ... ')
            { :actor => Person.new(values[0]), :character => values[1] }
          end
        end.compact
      end

      def parse_directors
        container = (page/'div#director-info').first
        (container/'a').map{|a| Person.new(a.inner_text)}
      end

      def parse_genres
        container = info_div('Genre')
        (container/'a').map{|a| a['href'].sub(/^.+\/([^\/]+)\/?$/, '\1')}.reject{|g| g == 'keywords'}
      end

      def parse_plot
        plot = info_div('Plot').inner_text
        plot.sub!(/^Plot:/, '')
        plot.sub!(/\s*\|\s*add synopsis$/, '')
        plot.sub!(/\s*\|\s*full synopsis$/, '')
        plot.sub!(/full summary$/, '')
        plot.sub!(/\(?more\)?$/, '')
        plot.strip
      end

      def parse_keywords
        container = info_div('Plot Keywords')
        (container/'a').map{|a| a['href'].sub(/^.+\/([^\/]+)\/?$/, '\1')}.reject{|k| k == 'keywords'}
      end

      def parse_tagline
        plot = info_div('Tagline').inner_text
        plot.sub!(/^Tagline:/, '')
        plot.sub!(/more$/, '')
        plot.strip
      end

      def parse_runtime
        container = info_div('Runtime')
        container.inner_text.match(/(\d+) min/)[1].to_i rescue nil
      end

      def parse_release_date
        parse_date info_div('Release Date')
      end

      def parse_date(container)
        if date = container.inner_text.match(/(\d+) (\w+) (\d{4})/)
          Date.civil(date[3].to_i, Date::MONTHNAMES.index(date[2]), date[1].to_i)
        end
      end

      def info_div(heading)
        (page/'div.info').find_all{|i| (i/'h5').inner_text =~ /^#{heading}\b/}.first
      end
  end
end
