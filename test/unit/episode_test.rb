require File.join(File.dirname(__FILE__), '..', 'helper')
require 'imdb'

class EpisodeTest < Test::Unit::TestCase
  # TODO: find out why shoulda resets @variables in setup every time, even when
  # you use ||= to set it.
  EPISODE = Imdb.find(583464)

  context 'Friends episode' do
    should 'should fetch the correct title' do
      assert_equal %Q(The One Where No One's Ready), EPISODE.title
    end

    should 'stringify' do
      assert_equal EPISODE.title, EPISODE.to_s
    end

    should 'have an array of genres' do
      assert_kind_of Array, EPISODE.genres
      assert_equal 'Comedy|Romance', EPISODE.genres.join('|')
    end

    should 'have a plot' do
      assert_equal 'Ross becomes very frustrated with his friends when they fail to be ready on time for a speech that he is giving at the museum. When he publicly moans at Rachel, she get her revenge by dressing outrageously.', EPISODE.plot
    end

    should 'have an array of keywords' do
      assert_kind_of Array, EPISODE.keywords
      assert_equal 'underwear|caller-id|real-time|reference-to-donald-duck|towel', EPISODE.keywords.join('|')
    end

    should 'have an array of directors' do
      assert_kind_of Array, EPISODE.directors
      assert_equal 'Gail Mancuso', EPISODE.directors.join('|')
    end

    should 'have an array of writers' do
      assert_kind_of Array, EPISODE.writers
      assert_equal 'David Crane|Marta Kauffman', EPISODE.writers.join('|')
    end

    should 'have an array of cast members' do
      assert_kind_of Array, EPISODE.cast
      assert_kind_of Hash, EPISODE.cast.first
      assert_kind_of Imdb::Person, EPISODE.cast.first[:actor]
    end

    should 'have starred that hot bird' do
      assert_equal 'Jennifer Aniston', EPISODE.cast.first[:actor].name
      assert_equal 'Rachel Green', EPISODE.cast.first[:character]
    end

    should 'have a rating' do
      assert_equal 84, EPISODE.rating
    end

    should 'have a poster_url' do
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BMTU4NzAxMTg3M15BMl5BanBnXkFtZTcwMzcxMTgxMQ@@._V1._SX100_SY136_.jpg', EPISODE.poster_url
    end

    should 'have an aired date' do
      assert_kind_of Date, EPISODE.aired_date
      assert_equal '1996/09/26', EPISODE.aired_date.strftime('%Y/%m/%d')
    end

    should 'be part of season 3' do
      assert_equal 3, EPISODE.season
    end

    should 'be episode number 2' do
      assert_equal 2, EPISODE.episode
    end

    should 'have a runtime' do
      assert_equal 22, EPISODE.runtime
    end

    should 'be a friends episode' do
      assert_kind_of Imdb::Series, EPISODE.series
      assert_equal '"Friends"', EPISODE.series.title
    end
  end
end
