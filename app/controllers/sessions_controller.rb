class SessionsController < ApplicationController


  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to current_user
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/sessions/new', notice: 'Invalid Credentials'
    end
  end

  def destroy
    current_user.session_id = nil
    current_user.save(validate: false)
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end
  
  def new
    if current_user
      redirect_to current_user
    end
  end

end
