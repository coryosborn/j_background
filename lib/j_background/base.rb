require 'java'
require 'logger'
require 'singleton'

# A singleton that utilizes Java's concurrency package to create a
# fixed sized thread pool capable of executing tasks asynchronously.
module JBackground
  class Base
    include Singleton

    # initializes the thread pool and defines a finalizer that forces all threads to shutdown
    def initialize
      @thread_pool = java.util.concurrent.Executors.newFixedThreadPool(JBackground::Base.pool_size || 5, JBackgroundThreadFactory.new)
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
  
  class JBackgroundThreadFactory
    include java.util.concurrent.ThreadFactory
    def new_thread(runnable)
      rv = java.lang.Thread.new(runnable);
      rv.setDaemon(true)
      rv
    end
  end
end
