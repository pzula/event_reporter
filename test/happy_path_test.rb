gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'


class EventReporterTest < Minitest::Test 

  def test_default_filename
    reporter = EventReporter.new
    assert_equal "event_attendees.csv", reporter.filename
  end

end