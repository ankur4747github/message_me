class SessionsController < ApplicationController

	before_action :login_redirect, only: [:new, :create]

	def new
	end	

	def create
		@user = User.find_by(email: params[:user][:username].downcase)
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			flash[:success] = "Successfully Loged in"
			redirect_to root_path
		else
			flash[:error] = "Invalid Login Information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Successfully Loged out"
		render 'new'
	end

	private

	def login_redirect
		if logged_in?
			redirect_to root_path
		end
	end

end