require 'csv'


class Attendee
  attr_reader :first_name, :last_name

  def initialize(data)
    @first_name = data[:first_name]
    @last_name = data[:last_name]
  end
end

class EventReporter
  attr_reader :filename
  # attr_accessor :first_name, :last_name, :phone_number

  def initialize(filename=nil)
    @filename = filename || "event_attendees.csv"
  end

  def attendees
    result = contents.map do |row|
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

  def initialize(data)
    @data = data
    @queue = []
  end

  def queue_count
    @queue.count
  end

  def find_first_name(input)
    @data.each do |row|
      if row[:first_name] == input
        @queue << row
      end
    end

    @queue
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

  def print_help
    File.open("help.txt", "r").read
  end

  def print_queue_help
    file = File.open("help.txt", "r")
    file.readlines[10]
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
      when "queue count" then print_queue_help 
    end
  end


end

