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
    @command = command
  end

  def help(options = nil)
    File.open("help.txt", "r").read
  end

  def message
    case @command
    when "help" then help
    end
  end


end

