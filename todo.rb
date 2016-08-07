#Suggested Classes and Methods:
#
#    List Class
#     x  Create a list
#     x  Add task to list
#     x  Show all tasks
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

	def show
		all_tasks
	end
end

class Task
	## need access to the task item
	attr_reader :description

	## need to convert the task to a string
	#   this is always done when a Task is handled
    def to_s
		description
	end

	## this is done only once, upon creation
	def initialize(description)
		@description = description
	end
end

if __FILE__ == $PROGRAM_NAME
	list = List.new
	puts 'You have created a new list'
	list.add(Task.new("First Task"))
	list.add(Task.new("Second Task"))
	puts 'You have added a Task'
	puts 'Showing Tasks'
	## puts because you have converted the tasks in the list to strings
	puts list.show
end 
