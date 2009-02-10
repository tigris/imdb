require File.join(File.dirname(__FILE__), '..', 'helper')
require 'imdb'

class SeriesTest < Test::Unit::TestCase
  # TODO: find out why shoulda resets @variables in setup every time, even when
  # you use ||= to set it.
  SERIES = Imdb.find(108778)
  UNPOPULATED = Imdb::Series.new(108778, 'Not Friends')

  context 'Friends' do
    should 'should fetch the correct title' do
      assert_equal '"Friends"', SERIES.title
    end

    should 'stringify' do
      assert_equal SERIES.title, SERIES.to_s
    end

    should 'have an array of genres' do
      assert_kind_of Array, SERIES.genres
      assert_equal 'Comedy|Romance', SERIES.genres.join('|')
    end

    should 'have a plot' do
      assert_equal 'The lives, loves, and laughs of six young friends living in Manhattan.', SERIES.plot
    end

    should 'have a tagline' do
      assert_equal 'You can never have enough Friends!', SERIES.tagline
    end

    should 'have an array of keywords' do
      assert_kind_of Array, SERIES.keywords
      assert_equal 'friend|love|actor|wedding|paleontologist', SERIES.keywords.join('|')
    end

    should 'have an array of creators' do
      assert_kind_of Array, SERIES.creators
      assert_equal 'David Crane|Marta Kauffman', SERIES.creators.join('|')
    end

    should 'have an array of cast members' do
      assert_kind_of Array, SERIES.cast
      assert_kind_of Hash, SERIES.cast.first
      assert_kind_of Imdb::Person, SERIES.cast.first[:actor]
    end

    should 'have some hot chick' do
      assert_equal 'Jennifer Aniston', SERIES.cast.first[:actor].name
      assert_equal 'Rachel Green', SERIES.cast.first[:character]
    end

    should 'have a year' do
      assert_equal 1994, SERIES.year
    end

    should 'have a release date' do
      assert_kind_of Date, SERIES.release_date
      assert_equal '1996/08/05', SERIES.release_date.strftime('%Y/%m/%d')
    end

    should 'have 10 seasons' do
      assert_equal 10, SERIES.seasons
    end

    should 'have a rating' do
      assert_equal 89, SERIES.rating
    end

    should 'have a runtime' do
      assert_equal 22, SERIES.runtime
    end

    should 'have a poster_url' do
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BODI3Nzc5NDA0NF5BMl5BanBnXkFtZTcwOTU0MzUyMQ@@._V1._SX100_SY134_.jpg', SERIES.poster_url
    end
  end

  context 'Unpopulated instance' do
    should 'populate stuff when required' do
      assert_equal 'Comedy|Romance', UNPOPULATED.genres.join('|')
      assert_equal 'The lives, loves, and laughs of six young friends living in Manhattan.', UNPOPULATED.plot
      assert_equal 'You can never have enough Friends!', UNPOPULATED.tagline
      assert_equal 'friend|love|actor|wedding|paleontologist', UNPOPULATED.keywords.join('|')
      assert_equal 'David Crane|Marta Kauffman', UNPOPULATED.creators.join('|')
      assert_equal 'Jennifer Aniston', UNPOPULATED.cast.first[:actor].name
      assert_equal 'Rachel Green', UNPOPULATED.cast.first[:character]
      assert_equal 1994, UNPOPULATED.year
      assert_equal '1996/08/05', UNPOPULATED.release_date.strftime('%Y/%m/%d')
      assert_equal 10, UNPOPULATED.seasons
      assert_equal 89, UNPOPULATED.rating
      assert_equal 22, UNPOPULATED.runtime
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BODI3Nzc5NDA0NF5BMl5BanBnXkFtZTcwOTU0MzUyMQ@@._V1._SX100_SY134_.jpg', UNPOPULATED.poster_url
    end

    should 'keep the original title after population' do
      assert_equal 'Not Friends', UNPOPULATED.title
    end
  end
end
