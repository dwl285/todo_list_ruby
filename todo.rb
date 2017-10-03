

module Menu
  def menu
    "Welcome to the todo List CLI. Choose
    an option from the list:
      1) Add
      2) Show
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
end

class Task
  attr_reader :description

  def initialize(description)
    @description = description
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
    else
      puts "Sorry, I didn't understand"
    end
  end
  puts "Thanks for using the menu system!"
end