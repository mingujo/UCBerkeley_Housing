# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'time'

Admin.create(email: "housingnotificationsystem@gmail.com")

# Event.create(id: 2,
# 			 start_time: Time.parse('2016-11-24 09:00:00'),
# 			 end_time: Time.parse('2016-11-24 09:30:00'),
# 			 ca_id: 1)
# Event.create(id: 4,
# 			 start_time: Time.parse('2016-11-24 14:00:00'),
# 			 end_time: Time.parse('2016-11-24 14:30:00'),
# 			 ca_id: 2)
# Event.create(id: 6,
# 			 start_time: Time.parse('2016-11-25 08:00:00'),
# 			 end_time: Time.parse('2016-11-25 08:30:00'),
# 			 ca_id: 1)
# Event.create(id: 7,
# 			 start_time: Time.parse('2016-11-24 15:00:00'),
# 			 end_time: Time.parse('2016-11-24 15:30:00'),
# 			 ca_id: 1)
			 
# Timeslot.create(id: 2,
# 				ca_id: 1,
# 				client_name: "James",
# 				phone_number: "510-123-1234",
# 				apt_number: "301",
# 				current_tenant: "George",
# 				starttime: Time.parse('2016-11-24 09:00:00'),
# 				endtime: Time.parse('2016-11-24 09:30:00'))
				
# Timeslot.create(id: 4,
# 				ca_id: 2,
# 				starttime: Time.parse('2016-11-24 14:00:00'),
# 				endtime: Time.parse('2016-11-24 14:30:00'))

# Timeslot.create(id: 6,
# 				ca_id: 1,
# 				starttime: Time.parse('2016-11-25 08:00:00'),
# 				endtime: Time.parse('2016-11-25 08:30:00'))

# Timeslot.create(id: 7,
# 				ca_id: 1,
# 				starttime: Time.parse('2016-11-24 15:00:00'),
# 				endtime: Time.parse('2016-11-24 15:30:00'))

				
# Ca.create(id: 1,
# 		  name: "Tony",
# 		  email: "tony@gmail.com",
# 		  phone_number: "510-411-1114")

# Ca.create(id: 2,
# 		  name: "Chris",
# 		  email: "chris@gmail.com",
# 		  phone_number: "510-233-1431")

# Ca.create(id: 3,
# 		  name: "Steve",
# 		  email: "steve@gmail.com",
# 		  phone_number: "510-356-2334")


# EventSeries.create(id: 1,
# 				   start_time: Time.parse('2016-11-01 10:00:00'),
# 				   end_time: Time.parse('2016-11-01 10:30:00'),
# 				   frequency: 2,
# 				   ca_id: 3)






