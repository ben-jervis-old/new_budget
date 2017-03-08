class UsersController < ApplicationController

  include ExpensesHelper

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @frequencies = freq_list
    if logged_in? && current_user != @user
      redirect_to current_user
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Sign up successful. Welcome to Paydollies'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    user_params.each do |field|
    end
  end

  def update_pay_period
    @user = User.find(params[:id])
    if @user.update_attribute(:pay_period, params[:user][:pay_period])
      flash[:success] = 'Pay period updated successfully'
      redirect_to @user
    else
      flash[:danger] = 'An error occurred while updating pay period'
      redirect_to @user
    end
  end

  private

    def user_params
      params.require(:user).permit( :name,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :pay_period)
    end
end
