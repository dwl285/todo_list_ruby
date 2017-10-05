

module Menu
  def menu
    "Welcome to the todo List CLI. Choose
    an option from the list:
      1) Add task
      2) Delete a task
      3) Update a task
      4) Show all tasks
      5) Write list to file
      6) Read list from file
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

  def delete(task_number)
    all_tasks.delete_at(task_number-1)
  end

  def update(task_number, task)
    all_tasks[task_number-1] = task
  end

  def show
    i = 1
    puts "Here's the contents of the list:"
    all_tasks.each {|t|
      puts "#{i}) #{t.description}"
      i+=1
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

  def read_from_file(filename)
    File.open(filename).each do |line|
      all_tasks. << Task.new(line)
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
      puts "Which tasks would you like to delete?"
      task_number = prompt(my_list.show,"")
      my_list.delete(task_number.to_i)
      puts "Task deleted"
    when "3"
      puts "Which tasks would you like to update?"
      task_number = prompt(my_list.show,"").to_i
      task = Task.new(prompt("What would you like to change it to?"))
      my_list.update(task_number, task)
      puts "Task updated"
    when "4"
      my_list.show
    when "5"
      filename = prompt("What would you like the filename to be?")
      my_list.write_to_file(filename)
      puts "Todo list written to #{filename}"
    when "6"
      filename = prompt("What's the filename of the list you'd like to read?")
      my_list.read_from_file(filename)
      puts "Todo list created from #{filename}"
    else
      puts "Sorry, I didn't understand"
    end
  end
  puts "Thanks for using the menu system!"
end