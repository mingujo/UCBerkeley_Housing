require_relative '../helpers/fetch_sheets.rb'

class Timeslot < ActiveRecord::Base
	belongs_to :ca
	validates_uniqueness_of :starttime

	after_create :write_spreadsheet

	def write_spreadsheet()
		if ENV["TESTING_ENV"] == "false"
			# :nocov:
			write_to_spreadsheet(self)
			# :nocov:
		end
	end
	
end
