require 'csv'

class EventReporter
  attr_reader :filename

  def initialize
    @filename = "event_attendees.csv"
  end

end   