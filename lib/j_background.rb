directory = File.dirname(__FILE__)
$:.unshift(directory) unless $:.include?(directory)
require 'j_background/base'
require 'j_background/task'
require 'j_background/proc_task'

# Task can be blocks or descendants of JBackground::Task.  For example:
#   JBackground.execute { puts "Hello from Thread #{Thread.current.object_id}" }
# or
#   JBackground.execute('Alan', 'Bob', 'Cory') { |x,y,z| puts "Hello #{x}, #{y}, and #{z}" }
# or
#   class ExampleTask < JBackground::Task
#     def execute_task
#       puts "Hello from ExampleTask" 
#     end
#   end
#
#   JBackground.execute(ExampleTask.new)
#
# The size of the thread pool can be defined as
#   JBackground::Base.pool_size = 2
# It will default to 5 and can not be changed after the first call to JBackground::Base#instance.
#
# The logger will default to STDOUT
# It can be set like this:
#   JBackground::Base.logger = RAILS_DEFAULT_LOGGER
module JBackground
  def self.execute(*args, &block)
    if block
      JBackground::Base.instance.execute(block, *args)
    else
      JBackground::Base.instance.execute(*args)
    end
  end
end
