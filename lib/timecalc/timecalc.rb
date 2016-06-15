module Timecalc

	# attr_reader :next_del_time :wait_til_del :freq :mail_creation_time 



	def next_del_time(freq, mail_creation_time)	
		# mail_creation_time = Time.new(2016,6,15,15,0,0,0)	
		freq = freq * 3600
		puts mail_creation_time

		if mail_creation_time.monday? && mail_creation_time.hour<=18   # if today monday before 6pm return mon 6pm
			next_del_time = Time.new(mail_creation_time.year,mail_creation_time.month,mail_creation_time.day, 18,0,0, "+00:00")
			wait_til_del = (next_del_time - mail_creation_time) / 3600
			return next_del_time, wait_til_del
		else # else iterate over mon 6pm + freq until after and return
			# first find last monday
			maybe_mon = mail_creation_time
			if !maybe_mon.monday?
				maybe_mon = maybe_mon - (24*3600)
			end
			# set route start time as 6pm last monday and increase by frequency until passes it
			prop_del_time = Time.new(maybe_mon.year,maybe_mon.month,maybe_mon.day, 18,0,0, "+00:00")
			while prop_del_time < mail_creation_time
				prop_del_time = prop_del_time + freq
			end
			next_del_time = prop_del_time
			wait_til_del = (mail_creation_time - next_del_time) / 3600
			return next_del_time, wait_til_del
		end
	end	
end