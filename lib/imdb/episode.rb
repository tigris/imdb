require 'date'

module Imdb
  class Episode < Base
    attr_accessor :directors, :writers, :series, :aired_date, :episode, :season

    def initialize(id, page)
      super(id, page)

      @directors  = parse_directors
      @writers    = parse_writers
      @series     = parse_series
      @aired_date = parse_aired_date
      @season     = parse_season
      @episode    = parse_episode

      self
    end

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
        id = container[:href].sub(/^.+tt(\d+).*$/, '').to_i
        title = container.inner_html.sub(/^&#34;(.+)&#34;.*$/, '"\1"')
        Series.new(id, title)
      end
  end
end
