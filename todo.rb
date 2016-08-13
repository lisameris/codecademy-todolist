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
#     x  As a user I can open a list from a text file
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
#     x  Read a list from a file
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
	 	(R/r) READ in a list from a file
		(Q/q) QUIT the program
		"
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
		# this is writing repeatedly - fix it
		IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
	end

	def read_from_file(filename)
		#alltasks = IO.readlines(filename)
		IO.foreach(filename) {|line| add(Task.new(line))}
	end

	def listfiles
		puts Dir["./*.txt"]
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


# Only run the following code when this file is the main file being run
# instead of having been required or loaded by another file
#
## Explanation:
#
# __FILE__ always returns the path of the source file. It's not a variable so you can't assign value to it.
# Whether it returns a relative path or an absolute one depends on how you run the script.
#
# $PROGRAM_NAME or $0 by default returns the command that boots the program (minus the path of the ruby 
# interpreter). 
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
		when 'a'
			# Add a Task
			list.add(Task.new(prompt('What is the task you want to add?')))
		when 's'
			# Show Task List
			puts list.show
		when 'w'
			# Write Task List to File
			list.write_to_file(prompt('What is the filename you want to write to?'))
		when 'r'
			# Read Task List from File
			list.listfiles
			begin
			list.read_from_file(prompt('What is the filename you want to read from?'))
				# rescue avoids erroring out when hitting an ERRNO
			rescue Errno::ENOENT
			puts 'File name not found, please verify your file name and path.'
			end
		else
			puts 'Sorry, I did not understand'
		end
	end
	puts 'Outro - Thanks for using the menu system!'
end 
