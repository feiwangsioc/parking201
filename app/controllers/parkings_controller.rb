class ParkingsController < ApplicationController

	def new
		@parking = Parking.new
	end

	def create 
	   @parking = Parking.new( :start_at => Time.now )

    # 有登入的话，根据用户选的费率。没有登入的话，指定是 guest 费率
     if current_user
       @parking.parking_type = params[:parking][:parking_type]
       @parking.user = current_user
     else
       @parking.parking_type = "guest"
     end
		@parking.save!

		redirect_to parking_path(@parking)
	end 

	def show
		@parking = Parking.find(params[:id])
	end 

	def update
		@parking = Parking.find(params[:id])
		@parking.end_at = Time.now
		@parking.calculate_amount

		@parking.save!

		redirect_to parking_path(@parking)
	end 


end
