module JBackground
  # a silly little task used by the tests
  class TestTask < JBackground::Task
    def self.thread_map
      @@thread_map
    end

    def self.total_incs
      @@total_incs
    end
    @@mutex = Mutex.new
    @@thread_map = {}
    @@total_incs = 0

    def self.inc_thread_count(thread_id)
      @@mutex.synchronize do
        @@thread_map[thread_id] ||= 0
        @@thread_map[thread_id] += 1

        @@total_incs += 1
      end
    end

    def execute_task
      sleep(rand)
      TestTask.inc_thread_count(Thread.current.object_id)
    end
  end
end