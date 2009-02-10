require 'date'

module Imdb
  class Episode < Base

    def directors;  @directors  ||= parse_directors;  end
    def writers;    @writers    ||= parse_writers;    end
    def series;     @series     ||= parse_series;     end
    def aired_date; @aired_date ||= parse_aired_date; end
    def season;     @season     ||= parse_season;     end
    def episode;    @episode    ||= parse_episode;    end

    protected
      def parse_title
        super.sub(/"[^"]+"/, '').strip
      end

      def parse_aired_date
        parse_date info_div('Original Air Date')
      end

      def parse_season
        container = info_div('Original Air Date')
        container.inner_text.match(/Season\s*(\d+)/)[1].to_i rescue nil
      end

      def parse_episode
        container = info_div('Original Air Date')
        container.inner_text.match(/Episode\s*(\d+)/)[1].to_i rescue nil
      end

      def parse_series
        container = (info_div('TV Series') / 'a').first
        id = container[:href].sub(/^.+tt(\d+).*$/, '\1').to_i
        title = container.inner_html.sub(/^&#34;(.+)&#34;.*$/, '"\1"')
        Series.new(id, title)
      end
  end
end
