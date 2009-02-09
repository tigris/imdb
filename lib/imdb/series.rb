module Imdb
  class Series < Base
    attr_accessor :creators, :tagline, :seasons, :year, :release_date

    def initialize(id, page)
      if page.is_a? Hpricot
        super(id, page)
        @year         = parse_year
        @tagline      = parse_tagline
        @creators     = parse_creators
        @seasons      = parse_seasons
        @release_date = parse_release_date
      else
        # TODO: how to convert this to a fully parsed object when required.
        @id    = id
        @title = page
      end
    end

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
