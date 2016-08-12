# Final Project for Codeacademy Ruby class: 
#  Ruby Command Line Todo List Program
#
# =========================
#
# Core User Stories
#
#     x  As a user I can create a todo list
#     x  As a user I can add tasks to the todo list
#     x  As a user I can see all the tasks in a list
#     x  As a user I can manipulate the todo list through a menu
#
# Secondary User Stories
#
#     x  As a user I can save a list to a text file
#        As a user I can open a list from a text file
#        As a user I can delete a task
#        As a user I can update a task
#
# Reach User Stories
#
#        As a user I can set a task status
#        As a user I can toggle a task status as complete or incomplete
#
# Suggested Classes and Methods:
#
#    List Class
#     x  Create a list
#     x  Add task to list
#     x  Show all tasks
#     x  Write a list to a file
#        Read a task from a file
#        Delete a task
#        Update a task
#    Task Class
#     x  Create a task item
########################################################################

module Menu
	def menu
		"Hello, User! Choose a task from the Todo Menu to: 
		(A/a) ADD a task
		(S/s) SHOW your tasks
		(W/w) WRITE a list to a file    (Not S-AVE, S is SHOW)
		(Q/q) QUIT the program
		"
	#	(R/r) READ in a list from a file
	end

	def show
		menu
	end
end

module Promptable
	def prompt(message = 'What would you like to do?', symbol = '      :> ')
		print message
		print symbol
		gets.chomp
	end
end

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

	def write_to_file(filename)
		IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
	end

	def read_from_file(filename)
		# IO.read(filename, @all_tasks.map(&:to_s).join("\n"))
	end
end

class Task
	## need access to the task item
	attr_reader :description

	## need to convert the task to a string
	#  this is always done when a Task is instantiated
	#  although you can't see it yet because there
	#  aren't any other actions other than initialize
    def to_s
		description
	end

	## this is done only once, upon creation
	def initialize(description)
		@description = description
	end
end


# if current file is same as program name
# prevents XXX 
if __FILE__ == $PROGRAM_NAME
	include Menu
	include Promptable
	list = List.new
	puts 'Please choose from the following list'
		# it's as bad as perl!
		# this obfuscated expression is saying
		#  the char 'q' is found in the user_input variable 
		#              that is the result of lowercasing prompt(show)
	until ['q'].include?(user_input = prompt(show).downcase)
		case user_input
		# Add a Task
		when 'a'
			list.add(Task.new(prompt('What is the task you want to add?')))
		# Read Task List from File
		when 'r'
			list.read_from_file(prompt('What is the filename you want to write to?'))
		# Write Task List to File
		when 'w'
			list.write_to_file(prompt('What is the filename you want to write to?'))
		# Show Task List
		when 's'
			puts list.show
		else
			puts 'Sorry, I did not understand'
		end
	end
	puts 'Outro - Thanks for using the menu system!'
end 
