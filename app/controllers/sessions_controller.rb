class SessionsController < ApplicationController

  def new
  end

  def create
    # we have the user's email/password from the params
    # 1. find the user by their email address
    # 2. if found, we authenticate the user with the given password
    # 3. if not found, we alert the user with wrong credentials

    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to  home_path, notice: 'Thanks for signing in!'
    else
      flash.now[:alert] = 'no user by those credientials!'
      render :new

    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "You've just logged out, see you next time!"
  end
  
end
