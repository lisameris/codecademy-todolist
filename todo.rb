#Suggested Classes and Methods:
#
#    List Class
#        Create a list
#        Add task to list
#        Show all tasks
#        Read a task from a file
#        Write a list to a file
#        Delete a task
#        Update a task
#    Task Class
#        Create a task item

class List
	attr_reader :all_tasks

	def initialize
		@all_tasks=[]
	end

	def add(task)
		all_tasks << task
	end
end

class Task
	attr_reader :description

	def initialize(description)
		@description = description
	end
end

if __FILE__ == $PROGRAM_NAME
  list = List.new
  puts 'You have created a new list'
end 
list.add("First Task")
puts 'You have added a Task'
