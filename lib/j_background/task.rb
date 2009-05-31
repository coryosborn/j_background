# The base class for all background tasks which implements the Java Runnable interface.
module JBackground
  class Task
    include java.lang.Runnable
    attr_accessor :logger

    def initialize
      self.logger = JBackground::Base.logger
    end

    def run
      logger.debug "Background Thread #{Thread.current.object_id} - Executing task: #{self.class.name} #{Time.now}"
      begin
        execute_task
      rescue => e
        logger.error "Background Thread #{Thread.current.object_id} - Error executing task: #{self.class.name} #{e}:\n#{e.backtrace.join('\n')}"
      end
      logger.debug "Background Thread #{Thread.current.object_id} - Finished task: #{self.class.name} #{Time.now}"
    end

    def execute_task
      puts "You have not defined a task"
    end
  end
end
