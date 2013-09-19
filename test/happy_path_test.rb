gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'

class AttendeeTest < Minitest::Test

  def test_attendee_attributes
    data = {:first_name => "Joe", 
            :last_name => "Smith", 
            :phone_number => "3306669955" }
    attendee = Attendee.new(data)
    assert_equal "Joe", attendee.first_name
    assert_equal "Smith", attendee.last_name
  end

end


class EventReporterTest < Minitest::Test 

  def test_default_filename
    reporter = EventReporter.new
    assert_equal "event_attendees.csv", reporter.filename
  end

  def test_default_filename_when_passing_nil_filename
    reporter = EventReporter.new(nil)
    assert_equal "event_attendees.csv", reporter.filename
  end

  def test_user_provided_filename
    reporter = EventReporter.new("fake.csv")
    assert_equal "fake.csv", reporter.filename
  end

  def test_file_loaded
    reporter = EventReporter.new("./test/fixtures/fake.csv")
    attendee = reporter.attendees.first
    assert_equal "Allison", attendee.first_name
    assert_equal "Nguyen", attendee.last_name
  end

end

class FinderTest < Minitest::Test

  def setup
    reporter = EventReporter.new("event_attendees.csv")
    contents = reporter.contents
    @finder = Finder.new(contents)
  end

  def test_queue_count_equals_zero
    assert_equal 0, @finder.queue_count
  end

  def test_find_first_name
    expected_count = 62
    actual = @finder.find_first_name("John") # => [ row1, row2, row12, row14 ]
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_queue_count_after_find_first_name
    expected_count = 62
    @finder.find_first_name("John")
    actual_count = @finder.queue_count
    assert_equal expected_count, actual_count
  end

  def test_queue_clear_returns_zero
    expected_count = 0
    @finder.queue_clear
    actual_count = @finder.queue_count
    assert_equal expected_count, actual_count
  end

end

class CommanderTest < Minitest::Test

  def setup 
    @robot = Commander.new
  end

  def test_help_with_no_parameter
    file = File.open("help.txt", "r")
    expected_output = file.read
    actual_output = @robot.help 
    assert_equal expected_output, actual_output
  end

end