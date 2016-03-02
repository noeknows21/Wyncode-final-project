class RoomsController < ApplicationController
  
  def create_private
    @session_id = $session.session_id
    @token = $session.generate_token
    
    current_user.token = $session.generate_token
    current_user.save
  end
  
  def create_sesh
    @opentok = OpenTok::OpenTok.new 45508312, "8face9e9bb645dd756bd1def75b786bbad83ea75"
    @session = @opentok.create_session :media_mode => :routed
    @session_id = @session.session_id
    @token = @session.generate_token
    
    current_user.token = @session.generate_token
    
    current_user.session_id = @session_id
    current_user.save
  end
  
  def create_hub
    @needed_id = current_user.id
    
    @opentok = OpenTok::OpenTok.new 45508312, "8face9e9bb645dd756bd1def75b786bbad83ea75"
    $session = @opentok.create_session :media_mode => :routed
  end
  
  def join_sesh
      chosen_user = User.find(params[:id])
      
      @session_id = chosen_user.session_id
      @token = chosen_user.token
      
      HTTParty.post('https://api.opentok.com/v2/partner/45508312/archive',
      { :body => { "sessionId" => "#{@session_id}", "hasAudio" => true, "hasVideo" => true, "outputMode" => "individual"}.to_json,
      :headers => { 'Content-Type' => 'application/json', 'X-TB-PARTNER-AUTH' => '45508312:8face9e9bb645dd756bd1def75b786bbad83ea75'}})  

  end
  
  def join_hub
    # @list1 = User.order(updated_at: :asc)
    if User.where.not(session_id: nil).last
      @list2 = User.where.not(session_id: nil)
    end
  end
  
  private
  
  def check_code
    redirect_to ('https://immense-savannah-32539.herokuapp.com/rooms/create_private/' + params[:code])
  end
  
  
end
