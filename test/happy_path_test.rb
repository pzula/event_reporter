gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/event_reporter'

class AttendeeTest < Minitest::Test

  def test_attendee_attributes
    data = {:first_name => "Joe", 
            :last_name => "Smith"}
    attendee = Attendee.new(data)
    assert_equal "Joe", attendee.first_name
    assert_equal "Smith", attendee.last_name
  end

  def test_it_cleans_up_phone_numbers_with_periods_and_hyphens
    attendee = Attendee.new(:first_name => "Joe", :last_name => "Smith", :email_address => "fake@gmail.com", :homephone => "202.444-9382")
    assert_equal "2024449382", attendee.homephone
  end

  def test_it_cleans_up_phone_numbers_with_spaces_and_parentheses
    attendee = Attendee.new(:first_name => "Joe", :last_name => "Smith", :email_address => "fake@gmail.com", :homephone => "(202) 444 9382")
    assert_equal "2024449382", attendee.homephone
  end

  def test_it_removes_leading_one_from_an_eleven_digit_phone_number
    attendee = Attendee.new(:first_name => "Joe", :last_name => "Smith", :email_address => "fake@gmail.com", :homephone => '12024449382')
    assert_equal "2024449382", attendee.homephone
  end

  def test_it_throws_away_phone_numbers_that_are_too_long
    attendee = Attendee.new(:first_name => "Joe", :last_name => "Smith", :email_address => "fake@gmail.com", :homephone => "23334445555")
    assert_equal "0000000000", attendee.homephone
  end

  def test_it_throws_away_phone_numbers_that_are_too_short
    attendee = Attendee.new(:first_name => "Joe", :last_name => "Smith", :email_address => "fake@gmail.com", :homephone => '222333444')
    assert_equal "0000000000", attendee.homephone
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
    attendee = reporter.create_attendees.first
    assert_equal "Allison", attendee.first_name
    assert_equal "Nguyen", attendee.last_name
  end

end

class FinderTest < Minitest::Test

  def setup
    @finder = Finder.new
  end

  def test_queue_count_equals_zero
    assert_equal 0, @finder.queue_count
  end

  def test_find_first_name
    expected_count = 63
    actual = @finder.find("first_name", "John") 
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_last_name
    expected_count = 35
    actual = @finder.find("last_name", "Smith") 
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_homephone
    expected_count = 1
    actual = @finder.find("homephone", "7188665000")
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_email_address
    expected_count = 1
    actual = @finder.find("email_address", "fpmorgan07@jumpstartlab.com")
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_city
    expected_count = 3
    actual = @finder.find("city", "Denver")
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_state
    expected_count = 29
    actual = @finder.find("state", "CO")
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_find_zipcode
    expected_count = 1
    actual = @finder.find("zipcode", "37216")
    actual_count = actual.count
    assert_equal expected_count, actual_count
  end

  def test_queue_count_after_find_first_name
    expected_count = 63
    @finder.find("first_name", "John")
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

  def test_help_method
    file = File.open("help.txt", "r")
    expected_output = file.read
    actual_output = @robot.print_help 
    assert_equal expected_output, actual_output
  end

  def test_help_command
    file = File.open("help.txt", "r")
    expected_output = file.read
    command = Commander.new("help")
      
    assert_equal expected_output, command.fetch_message
  end
     
  def test_help_with_queue_count_option
    command = Commander.new("help queue count")
    file = File.open("help.txt", "r")
    expected_output = file.readlines[10]
    assert_equal expected_output, command.process_commands
  end
     
  def test_help_with_queue_print_option
    command = Commander.new("help queue print")
    file = File.open("help.txt", "r")
    expected_output = file.readlines[15, 17]
    assert_equal expected_output, command.process_commands
  end

end