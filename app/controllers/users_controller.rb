class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_user

  def show
  end 

  def edit
    # @user = current_user
    # @user.create_profile unless @user.profile
  end

  def update
    # @user = current_user

    if @user.update(user_params)
      flash[:notice] = "修改成功"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

   def find_user
     @user = current_user
     @user.create_profile unless @user.profile
   end



  protected

  def user_params
    params.require(:user).permit(:time_zone, :profile_attributes => [:id, :legal_name, :birthday, :location, :education, :occupation, :bio, :specialty] )
  end


end
