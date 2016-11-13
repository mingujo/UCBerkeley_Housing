include TimeslotHelper

class TimeslotController < ApplicationController
	# before_action :set_timeslot, only: [:show, :edit, :update, :destroy]

	# def timeslot_params
	# 	params.require(:timeslot).permit(:starttime,
	# 									 :ca_id)
	# end
  
	def index
		# params.require(:ca).permit(:name, :email, :phone_number)
	end
	
	# def create
	# 	params.permit!
	# 	@timeslot = Timeslot.create(timeslot_params, :endtime => add_30min(params[:starttime]))
	# 	#if @timeslot.save
	# end
	# def create
	# 	print "In create method"
	# 	params.permit!
	# 	@ca = Ca.create(ca_params)
		
	# 	if @ca.save
	# 		puts "In create now saving and redirecting to"
	# 		redirect_to cas_path
	# 	else
	# 		redirect_to action: 'error'
	# 	end
		
	# end
	
	# def delete
		
	# end
end
