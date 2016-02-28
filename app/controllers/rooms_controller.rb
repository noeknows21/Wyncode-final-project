class RoomsController < ApplicationController
  
  def create_private

    @session_id = $session.session_id
    @token = $session.generate_token
    
    current_user.token = $session.generate_token
    current_user.save
  end
  
end
