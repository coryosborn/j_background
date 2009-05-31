# A descandant of JBackground::Task that execute's a Proc as its task.  This allows
# JBackground to execute blocks as tasks.
module JBackground
  class ProcTask < Task
    def initialize(proc, *args)
      super()
      @proc = proc
      @args = args
    end

    def execute_task
      @proc.call(*(@args))
    end
  end
end