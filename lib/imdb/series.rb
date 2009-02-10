module Imdb
  class Series < Base
    def initialize(id, page)
      if page.is_a? Hpricot
        super(id, page)
      else
        @id    = id
        @title = page
      end
    end

    def year;         @year         ||= parse_year;         end
    def tagline;      @tagline      ||= parse_tagline;      end
    def release_date; @release_date ||= parse_release_date; end
    def creators;     @creators     ||= parse_creators;     end
    def seasons;      @seasons      ||= parse_seasons;      end

    #TODO: episodes(season = nil) - to return array of Imdb::Episode objects for that season (nil for all)

    protected
      def parse_cast
        cast = super
        cast.each{|p| p[:character].sub!(/ \(.*episodes.*\)$/, '')}
        cast
      end

      def parse_creators
        container = info_div('Creators')
        (container/'a').map{|a| Person.new(a.inner_text)}.reject{|p| p.name == 'more'}
      end

      def parse_seasons
        container = info_div('Seasons')
        (container/'a').map{|a| a.inner_text}.reject{|k| k !~ /^\d+$/}.last.to_i
      end
  end
end
