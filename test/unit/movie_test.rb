require File.join(File.dirname(__FILE__), '..', 'helper')
require 'imdb'

class MovieTest < Test::Unit::TestCase
  # TODO: find out why shoulda resets @variables in setup every time, even when
  # you use ||= to set it.
  TOP_GUN = Imdb.find(92099)
  PULSE   = Imdb.find(454919)

  context 'Top Gun' do
    should 'should fetch the correct title' do
      assert_equal 'Top Gun', TOP_GUN.title
    end

    should 'stringify' do
      assert_equal TOP_GUN.title, TOP_GUN.to_s
    end

    should 'have an array of genres' do
      assert_kind_of Array, TOP_GUN.genres
      assert_equal 'Action|Romance', TOP_GUN.genres.join('|')
    end

    should 'have a plot' do
      assert_equal 'The macho students of an elite US Flying school for advanced fighter pilots compete to be best in the class, and one romances the teacher.', TOP_GUN.plot
    end

    # Whoever at IMDB gave Top Gun a tagline like this should be shot.
    should 'have a lame ass tagline' do
      assert_equal 'From the Producers of Beverly Hills Cop and Flashdance [UK Theatrical]', TOP_GUN.tagline
    end

    should 'have an array of keywords' do
      assert_kind_of Array, TOP_GUN.keywords
      assert_equal 'pilot|fighter-pilot|singing|made-an-example-of|us-navy', TOP_GUN.keywords.join('|')
    end

    should 'have an array of directors' do
      assert_kind_of Array, TOP_GUN.directors
      assert_equal 'Tony Scott', TOP_GUN.directors.join('|')
    end

    should 'have an array of writers' do
      assert_kind_of Array, TOP_GUN.writers
      assert_equal 'Ehud Yonay|Jim Cash', TOP_GUN.writers.join('|')
    end

    should 'have an array of cast members' do
      assert_kind_of Array, TOP_GUN.cast
      assert_kind_of Hash, TOP_GUN.cast.first
      assert_kind_of Imdb::Person, TOP_GUN.cast.first[:actor]
    end

    should 'have starred Tom Cruise' do
      assert_equal 'Tom Cruise', TOP_GUN.cast.first[:actor].name
      assert_equal %Q(Lt. Pete 'Maverick' Mitchell), TOP_GUN.cast.first[:character]
    end

    should 'have a year' do
      assert_equal 1986, TOP_GUN.year
    end

    should 'have a release date' do
      assert_kind_of Date, TOP_GUN.release_date
      assert_equal '1986/07/31', TOP_GUN.release_date.strftime('%Y/%m/%d')
    end

    should 'have a much better rating than this' do
      assert_equal 65, TOP_GUN.rating
    end

    should 'have a runtime' do
      assert_equal 110, TOP_GUN.runtime
    end

    should 'have a poster_url' do
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BMjE0MDE1MTQ5MF5BMl5BanBnXkFtZTcwNzYwOTA4MQ@@._V1._SX100_SY140_.jpg', TOP_GUN.poster_url
    end
  end

  context 'Pulse' do
    should 'parse writers' do
      assert_kind_of Array, PULSE.writers
    end
  end
end
