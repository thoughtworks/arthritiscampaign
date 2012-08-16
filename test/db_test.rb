require './app'
require 'test/unit'
require 'rack/test'
require_relative '../lib/repository'

class RepositoryTest < Test::Unit::TestCase
 
  def setup
    Repository.db["submissions"].remove
  end

  def test_can_save_submission
    submission = {'name' => 'test'}
    Repository.save_submission(submission)
    
    actual = Repository.db["submissions"].find_one({:name => 'test'})
    assert_not_nil actual
  end

  def test_can_get_all_submissions
    Repository.db["submissions"].save( {"name"=>"test1"})
    Repository.db["submissions"].save( {"name"=>"test2"})
    Repository.db["submissions"].save( {"name"=>"test3"})
    submissions = Repository.submissions
    puts submissions.inspect
    assert_equal 3, submissions.count
    assert_equal 'test1', submissions[0]['name']
    assert_equal 'test2', submissions[1]['name']
    assert_equal 'test3', submissions[2]['name']
  end

end
