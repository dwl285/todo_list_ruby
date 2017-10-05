

module Menu
  def menu
    "Welcome to the todo List CLI. Choose
    an option from the list:
      1) Add
      2) Show
      3) Write list to file
      Q) Quit the program\n"
  end

  def show
    menu
  end
end

module Promptable
  def prompt(message="Would would you like to do?", 
             prompt = ">")
    print message
    print prompt
    gets.chomp
  end
end

#Classes

class List
  attr_reader :all_tasks

  def initialize()
    @all_tasks = []
  end

  def add(task)
    all_tasks << task
  end

  def show
    puts "Here's the contents of the list:"
    all_tasks.each {|t|
      puts t.description
    }
    print "\n"
  end

  def write_to_file(filename)
    File.new(filename, "w+")
    File.open(filename, "w+") do |f|
      all_tasks.each do |task|
        f.puts(task.to_s)
      end
    end
  end
end

class Task
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def to_s
    description.to_s
  end
end

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable

  my_list = List.new
  puts 'Please choose from the following options:'

  until ['q'].include?(user_input = prompt(show).downcase) do
    case user_input
    when "1"
      task = prompt("What's the task?\n")
      my_list.add(Task.new(task))
      puts "Task added"
    when "2"
      my_list.show
    when "3"
      filename = prompt("What would you like the filename to be?")
      my_list.write_to_file(filename)
      puts "Todo list written to #{filename}"
    else
      puts "Sorry, I didn't understand"
    end
  end
  puts "Thanks for using the menu system!"
end