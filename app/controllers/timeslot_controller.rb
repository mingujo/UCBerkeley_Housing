class TimeslotController < ApplicationController
	# before_action :set_ca, only: [:show, :edit, :update, :destroy]
	
	def index
		# params.require(:ca).permit(:name, :email, :phone_number)
	end
	
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
