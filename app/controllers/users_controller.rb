class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  ### before_action :authorize, except: [:new, :create]


  # GET /users
  # GET /users.json
  def index
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

  # GET /users/1
  # GET /users/1.json
  def show
    current_user.session_id = nil
    current_user.save
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Account was successfully created.'
    else
      render :new
    end
  end
  

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    session[:user_id] = nil
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :session_id, :allow_join, :token)
    end
end
