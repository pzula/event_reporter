class CommandCenter

  def command
    instruction = ""
    while instruction != "quit"
      printf "Enter Command: "
      input = gets.chomp
      parts = input.split(" ")
      instruction = parts[0]
      parse_instruction(instruction)
    end 
  end

  def parse_instruction(command)
    quitmessage = "Thank you for using the Event Reporter! Goodbye."
    case command
        when 'quit' 
          puts quitmessage
          return quitmessage
        when 'help' then help(parts[1])
      end
  end

  def help(command)
    if command == nil
      puts "
      The commands available to you are:
      
      HELP 
      ----
      help <command>

      LOAD
      ----
      load <filename>

      QUEUE
      -----
      queue
      queue count
      queue print
      queue print by <attribute>
      queue save to <filename.csv>
      queue clear

      FIND 
      ----
      find <attribute> <criteria>
      "
    elsif command == "help"
      puts "This command outputs a listing of the available 
      individual commands help <command> will output a description 
      for how to use the specific command"
    elsif command == "queue"
      puts "This should be edited"
    else
      puts "I cannot understand what sort of help you are looking for. Perhaps simply try typing 'help'."
    end
  end

end