require 'date'

module Imdb
  class Movie < Base
    def year;         @year         ||= parse_year;         end
    def writers;      @writers      ||= parse_writers;      end
    def release_date; @release_date ||= parse_release_date; end
    def directors;    @directors    ||= parse_directors;    end
    def tagline;      @tagline      ||= parse_tagline;      end
  end
end
