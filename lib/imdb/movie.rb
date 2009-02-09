require 'date'

module Imdb
  class Movie < Base
    attr_accessor :year, :writers, :directors, :tagline, :release_date

    def initialize(id, page)
      super(id, page)

      @year         = parse_year
      @writers      = parse_writers
      @directors    = parse_directors
      @tagline      = parse_tagline
      @release_date = parse_release_date

      self
    end
  end
end
