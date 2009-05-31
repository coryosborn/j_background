require 'test_helper'
require 'timeout'
require 'j_background/test_task'

class JBackgroundTest < Test::Unit::TestCase
  def test_execute_proc
    main_thread_id = Thread.current.object_id
    proc_thread_id = nil
    JBackground.execute { proc_thread_id = Thread.current.object_id }
    Timeout::timeout(5) { while proc_thread_id.nil? do sleep(0.1) end }
    assert_not_nil proc_thread_id
    assert_not_equal main_thread_id, proc_thread_id
  end
  
  def test_execute_proc_with_args
    main_thread_id = Thread.current.object_id
    proc_thread_id = nil
    JBackground.execute('Alan', 'Bob', 'Cory') do |*args|  
      assert_equal 3, args.size
      proc_thread_id = Thread.current.object_id
    end
    Timeout::timeout(5) { while proc_thread_id.nil? do sleep(0.1) end }
    assert_not_nil proc_thread_id
    assert_not_equal main_thread_id, proc_thread_id
  end
  
  def test_execute_task
    20.times { JBackground.execute(JBackground::TestTask.new) }
    Timeout::timeout(30) { while JBackground::TestTask.total_incs < 20 do sleep(0.1) end }
    assert_equal 20, JBackground::TestTask.total_incs
    assert_equal 5, JBackground::TestTask.thread_map.size
  end
end
