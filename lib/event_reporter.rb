require 'csv'

class EventReporter

  def initialize
    puts "EventManager initialized."
  end

  def load_csv(filename)
    if filename == nil
      default = './event_attendees.csv'
      contents = CSV.open default, headers: true, header_converters: :symbol
      return default
    else
      contents = CSV.open filename, headers: true, header_converters: :symbol
    end
    # contents.each do |row|
    #   id = row[0]
    #   name = row[:first_name]
    #   phone = clean_phone_number(row[:homephone])
    #   zipcode = clean_zipcode(row[:zipcode])
  end

end   