require 'java'
require 'logger'
require 'singleton'

# A singleton that utilizes Java's concurrency package to create a
# fixed sized thread pool capable of executing tasks asynchronously.
#
# Task can be blocks or descendants of JBackgroundTask.  For example:
#   JBackground.execute { puts "Hello from Thread #{Thread.current.object_id}" }
# or
#   JBackground.execute('Alan', 'Bob', 'Cory') { |x,y,z| puts "Hello #{x}, #{y}, and #{z}" }
# or
#   class ExampleTask < JBackgroundTask
#     def execute_task
#       puts "Hello from ExampleTask" 
#     end
#   end
#
#   JBackground.execute(ExampleTask.new)
#
# The size of the thread pool can be defined as
#   JBackground.pool_size = 2
# It will default to 5 and can not be changed after the first call to #instance.
#
# The logger will default to STDOUT
# It can be set like this:
#   JBackground.logger = RAILS_DEFAULT_LOGGER
module JBackground
  class Base
    include Singleton

    # initializes the thread pool and defines a finalizer that forces all threads to shutdown
    def initialize
      @thread_pool = java.util.concurrent.Executors.newFixedThreadPool(JBackground::Base.pool_size || 5)
      ObjectSpace.define_finalizer(@thread_pool) do
        @thread_pool.shutdown_now
      end
    end

    # singleton's instance method for executing a task
    def execute(*args, &block)
      if block
        @thread_pool.execute(JBackground::ProcTask.new(block, args))
      elsif args[0].is_a? Proc
        @thread_pool.execute(JBackground::ProcTask.new(*args))
      elsif args[0].is_a? JBackground::Task
        @thread_pool.execute(args[0])
      else
        raise "Invalid task"
      end
    end

    # changing pool_size after the first call to #instance has no effect
    @@pool_size = 5
    def self.pool_size
      @@pool_size
    end

    def self.pool_size=(value)
      @@pool_size = value
    end

    def self.logger
      @@logger ||= Logger.new(STDOUT)
    end

    def self.logger=(value)
      @@logger = value
    end
  end
end
