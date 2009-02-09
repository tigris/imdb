require File.join(File.dirname(__FILE__), '..', 'helper')
require 'imdb'

class MovieTest < Test::Unit::TestCase
  # TODO: find out why shoulda resets @variables in setup every time, even when
  # you use ||= to set it.
  MOVIE = Imdb.find(92099)

  context 'Top Gun' do
    should 'should fetch the correct title' do
      assert_equal 'Top Gun', MOVIE.title
    end

    should 'stringify' do
      assert_equal MOVIE.title, MOVIE.to_s
    end

    should 'have an array of genres' do
      assert_kind_of Array, MOVIE.genres
      assert_equal 'Action|Romance', MOVIE.genres.join('|')
    end

    should 'have a plot' do
      assert_equal 'The macho students of an elite US Flying school for advanced fighter pilots compete to be best in the class, and one romances the teacher.', MOVIE.plot
    end

    # Whoever at IMDB gave Top Gun a tagline like this should be shot.
    should 'have a lame ass tagline' do
      assert_equal 'From the Producers of Beverly Hills Cop and Flashdance [UK Theatrical]', MOVIE.tagline
    end

    should 'have an array of keywords' do
      assert_kind_of Array, MOVIE.keywords
      assert_equal 'pilot|fighter-pilot|singing|made-an-example-of|us-navy', MOVIE.keywords.join('|')
    end

    should 'have an array of directors' do
      assert_kind_of Array, MOVIE.directors
      assert_equal 'Tony Scott', MOVIE.directors.join('|')
    end

    should 'have an array of writers' do
      assert_kind_of Array, MOVIE.writers
      assert_equal 'Ehud Yonay|Jim Cash', MOVIE.writers.join('|')
    end

    should 'have an array of cast members' do
      assert_kind_of Array, MOVIE.cast
      assert_kind_of Hash, MOVIE.cast.first
      assert_kind_of Imdb::Person, MOVIE.cast.first[:actor]
    end

    should 'have starred Tom Cruise' do
      assert_equal 'Tom Cruise', MOVIE.cast.first[:actor].name
      assert_equal %Q(Lt. Pete 'Maverick' Mitchell), MOVIE.cast.first[:character]
    end

    should 'have a year' do
      assert_equal 1986, MOVIE.year
    end

    should 'have a release date' do
      assert_kind_of Date, MOVIE.release_date
      assert_equal '1986/07/31', MOVIE.release_date.strftime('%Y/%m/%d')
    end

    should 'have a much better rating than this' do
      assert_equal 65, MOVIE.rating
    end

    should 'have a poster_url' do
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BMjE0MDE1MTQ5MF5BMl5BanBnXkFtZTcwNzYwOTA4MQ@@._V1._SX100_SY140_.jpg', MOVIE.poster_url
    end
  end
end
