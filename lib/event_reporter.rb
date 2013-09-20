require 'csv'


class Attendee
  attr_reader :first_name, :last_name, :email_address, :homephone, :city, :state, :zipcode


  def initialize(data)
    @first_name = clean_name(data[:first_name])
    @last_name = clean_name(data[:last_name])
    @email_address = data[:email_address]
    @homephone = clean_phone_number(data[:homephone])
    @city = data[:city]
    @state = data[:state]
    @zipcode = clean_zip_code(data[:zipcode])
  end

  def clean_name(name)
    name.capitalize
  end

  def clean_phone_number(number)
    if number
      number = number.scan(/[0-9]/).join
      if number.length == 11 && number.start_with?("1")
        number= number[1..-1]
      end
      if number.length != 10
        number = "0000000000"
      end

      return number
    end
  end

  def clean_zip_code(zip)
    zip.to_s.rjust(5, '0')[0..4]
  end

end

class EventReporter
  attr_reader :filename, :attendees
  # attr_accessor :first_name, :last_name, :phone_number

  def initialize(filename = nil)
    @filename = filename || "event_attendees.csv"
  end

  def create_attendees
    @attendees = contents.map do |row|
      Attendee.new(row)
    end
  end

  def contents
    @contents ||= load_data
  end

  def load_data
    CSV.read filename, headers: true, header_converters: :symbol
  end

end

class Finder 
  attr_accessor :queue

  def initialize
    @data = EventReporter.new.create_attendees
    @queue = []
  end

  def find(attribute, value)
    @data.each do |attendee|
      if attendee.send(attribute.to_sym) == value
        @queue << attendee
      end
    end
    @queue
  end

  def queue_count
    @queue.count
  end

  def queue_clear
    @queue.clear
  end

end

class Commander

  attr_accessor :command

  def initialize(command = nil)
    if command != nil
      command_parts = command.split(" ")
      @command = command_parts[0]
      @options = command_parts[1..2].join(" ")
    end
  end

  def process_commands
    if @options.nil?
      fetch_message
    else
      fetch_options 
    end
  end

  def fetch_message
    case @command
      when "help" then print_help
    end
  end

  def fetch_options
    case @options
      when "queue count" then print_queue_count_help 
      when "queue print" then print_queue_print_help
    end
  end

  def print_help
    File.open("help.txt", "r").read
  end

  def print_queue_count_help
    file = File.open("help.txt", "r")
    file.readlines[10]
  end

  def print_queue_print_help
    file = File.open("help.txt", "r")
    file.readlines[15, 17]
  end



end

