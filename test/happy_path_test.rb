require 'minitest'
require 'minitest/autorun'
require './lib/event_reporter'

class HappyPathTest < Minitest::Test
  attr_accessor :reporter 

  def setup
    @reporter = EventReporter.new
  end 

  def test_will_load_file_if_nil
    filename = nil
    assert_equal "event_attendees.csv", reporter.load_csv(filename)
  end

  def test_will_load_file_with_name
    filename = "event_attendees_copy.csv"
    assert_equal filename, reporter.load_csv(filename)
  end


end 