require 'csv'

class Attendee

  attr_accessor :first_name, :last_name, :homephone

  def initialize(input = {})
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    @homephone = clean_phone_number(input[:homephone])
  end
  
  def load_attendee
    puts "EventManager initialized."

    contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

    contents.each do |row|
      id = row[0]
      name = row[:first_name]
      phone = clean_phone_number(row[:homephone])
    end
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

end


