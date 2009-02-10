require File.join(File.dirname(__FILE__), '..', 'helper')
require 'imdb'

class EpisodeTest < Test::Unit::TestCase
  # TODO: find out why shoulda resets @variables in setup every time, even when
  # you use ||= to set it.
  FRIENDS = Imdb.find(583464)
  SUPERNATURAL = Imdb.find(835248)

  context 'Friends episode' do
    should 'should fetch the correct title' do
      assert_equal %Q(The One Where No One's Ready), FRIENDS.title
    end

    should 'stringify' do
      assert_equal FRIENDS.title, FRIENDS.to_s
    end

    should 'have an array of genres' do
      assert_kind_of Array, FRIENDS.genres
      assert_equal 'Comedy|Romance', FRIENDS.genres.join('|')
    end

    should 'have a plot' do
      assert_equal 'Ross becomes very frustrated with his friends when they fail to be ready on time for a speech that he is giving at the museum. When he publicly moans at Rachel, she get her revenge by dressing outrageously.', FRIENDS.plot
    end

    should 'have an array of keywords' do
      assert_kind_of Array, FRIENDS.keywords
      assert_equal 'underwear|caller-id|real-time|reference-to-donald-duck|towel', FRIENDS.keywords.join('|')
    end

    should 'have an array of directors' do
      assert_kind_of Array, FRIENDS.directors
      assert_equal 'Gail Mancuso', FRIENDS.directors.join('|')
    end

    should 'have an array of writers' do
      assert_kind_of Array, FRIENDS.writers
      assert_equal 'David Crane|Marta Kauffman', FRIENDS.writers.join('|')
    end

    should 'have an array of cast members' do
      assert_kind_of Array, FRIENDS.cast
      assert_kind_of Hash, FRIENDS.cast.first
      assert_kind_of Imdb::Person, FRIENDS.cast.first[:actor]
    end

    should 'have starred that hot bird' do
      assert_equal 'Jennifer Aniston', FRIENDS.cast.first[:actor].name
      assert_equal 'Rachel Green', FRIENDS.cast.first[:character]
    end

    should 'have a rating' do
      assert_equal 84, FRIENDS.rating
    end

    should 'have a poster_url' do
      assert_equal 'http://ia.media-imdb.com/images/M/MV5BMTU4NzAxMTg3M15BMl5BanBnXkFtZTcwMzcxMTgxMQ@@._V1._SX100_SY136_.jpg', FRIENDS.poster_url
    end

    should 'have an aired date' do
      assert_kind_of Date, FRIENDS.aired_date
      assert_equal '1996/09/26', FRIENDS.aired_date.strftime('%Y/%m/%d')
    end

    should 'be part of season 3' do
      assert_equal 3, FRIENDS.season
    end

    should 'be episode number 2' do
      assert_equal 2, FRIENDS.episode
    end

    should 'have a runtime' do
      assert_equal 22, FRIENDS.runtime
    end

    should 'be a friends episode' do
      assert_kind_of Imdb::Series, FRIENDS.series
      assert_equal '"Friends"', FRIENDS.series.title
      assert_not_equal 0, FRIENDS.series.id
    end
  end

  context 'Supernatural episode' do
    should 'have a plot that does not end with "more"' do
      assert SUPERNATURAL.plot !~ /more$/
    end
  end
end
