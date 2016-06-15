
require "test_helper"
require "timecalc/timecalc"

class TimeCalcTests < ActiveSupport::TestCase
	include Timecalc
	# def mon_del
	# 	@mon_del = Time.new(2016,6,13,15,0,0,0)
	# end

	def weds_del
		@wed_del = Time.new(2016,6,15,15,0,0,0)
	end

	test "monday morning mail creation" do
		mon_del = Time.new(2016,6,13,10,0,0,0)
		del, wait = next_del_time(18, mon_del)		
		assert_equal del.day, 13
		assert_equal del.hour, 18
		assert_equal wait, 8
	end

	test "monday 6pm mail creation " do
		mon_del = Time.new(2016,6,13,18,0,0,0)
		del, wait = next_del_time(18, mon_del)		
		assert_equal del.day, 13
		assert_equal del.hour, 18
	end

	test "monday after 6pm mail  creation" do
		mon_del = Time.new(2016,6,13,20,0,0,0)
		del, wait = next_del_time(18, mon_del)		
		assert_equal del.day, 14
		assert_equal del.hour, 12
	end


	test "tuesday creation" do
		tues_del = Time.new(2016,6,14,20,0,0,0)
		del, wait = next_del_time(18, tues_del)		
		assert_equal del.day, 15
		assert_equal del.hour, 6
	end

end