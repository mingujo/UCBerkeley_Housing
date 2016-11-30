class Timeslot < ActiveRecord::Base
	belongs_to :ca
	attr_accessor :id
	
end
