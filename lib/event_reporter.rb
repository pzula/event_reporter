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
    result = []
    contents.each do |row|
      result << Attendee.new(row)
    end
    result
  end

  private

  def contents
    @contents ||= load_data
  end

  def load_data
    CSV.open filename, headers: true, header_converters: :symbol
  end

end

