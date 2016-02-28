class RoomsController < ApplicationController
  
  def create_private

    @session_id = $session.session_id
    @token = $session.generate_token
    
    current_user.token = $session.generate_token
    current_user.save
  end
  
  def create_sesh
    @opentok = OpenTok::OpenTok.new 45507072, "dee03bbe56d0e633306e6293b9bf69e97d3e8e10"
    @session = @opentok.create_session :archive_mode => :always, :media_mode => :routed
    @session_id = @session.session_id
    @token = @session.generate_token
    
    current_user.token = @session.generate_token
    
    current_user.session_id = @session_id
    current_user.save
  end
  
  def create_hub
    @needed_id = current_user.id
    
    @opentok = OpenTok::OpenTok.new 45507072, "dee03bbe56d0e633306e6293b9bf69e97d3e8e10"
    $session = @opentok.create_session :archive_mode => :always, :media_mode => :routed
  end
  
  def join_sesh
      chosen_user = User.find(params[:id])
      
      @session_id = chosen_user.session_id
      @token = chosen_user.token

  end
  
  def join_hub
    # @list1 = User.order(updated_at: :asc)
    if User.where.not(session_id: nil).last
      @list2 = User.where.not(session_id: nil)
    end
  end
  
end
