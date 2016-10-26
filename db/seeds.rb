# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

timeslots =  [{:time => '8:00 AM'},
	    	  {:time => '8:30 AM'},
	    	  {:time => '9:00 AM'},
	      	  {:time => '9:30 AM'},
	      	  {:time => '10:00 AM'},
	      	  {:time => '10:30 AM'},
	      	  {:time => '11:00 AM'},
	      	  {:time => '11:30 AM'},
	      	  {:time => '12:00 PM'},
	      	  {:time => '12:30 PM'},
	      	  {:time => '1:00 PM'},
	      	  {:time => '1:30 AM'},
	      	  {:time => '2:00 PM'},
	      	  {:time => '2:30 PM'},
	      	  {:time => '3:00 PM'},
	      	  {:time => '3:30 PM'},
	      	  {:time => '4:00 PM'},
	      	  {:time => '4:30 PM'},
	      	  {:time => '5:00 PM'},
	      	  {:time => '5:30 PM'}
  		]

TIMESLOT_TABLES = [Timeslot1, Timeslot2, Timeslot3, Timeslot4, Timeslot5, 
				   Timeslot6, Timeslot7, Timeslot8, Timeslot9, Timeslot10, 
				   Timeslot11, Timeslot12, Timeslot13, Timeslot14, Timeslot15, 
				   Timeslot16, Timeslot17, Timeslot18, Timeslot19, Timeslot20, 
				   Timeslot21, Timeslot22, Timeslot23, Timeslot24, Timeslot25, 
				   Timeslot26, Timeslot27, Timeslot28, Timeslot29, Timeslot30,
				   Timeslot31]
				   
TIMESLOT_TABLES.each do |table|
	timeslots.each do |time|
	  table.create!(time)
	end
end