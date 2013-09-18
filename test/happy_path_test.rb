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

  def test_find_first_name
    reporter = EventReporter.new("./test/fixtures/fake.csv")
    attendee = reporter.attendees.first
    assert_equal "Allison", attendee.first_name
    assert_equal "Nguyen", attendee.last_name
  end


  ###
  ###  Once I figure out how to store the data in a hash, 
  ###  some tests about finding some folks named John 
  ###  and counting them goes here
  ###






end