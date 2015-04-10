class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]

  layout 'my_account', only: [:edit, :destroy, :update]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.id.to_s == current_user.id.to_s 
      @votings = Voting.where(user_id: params[:id])
       @interesting_votings = Voting.in(tags: current_user.interests).ne(user_id: current_user.id)
      render layout: 'my_account'
    else
      @votings = Voting.where(user_id: params[:id]).general_audience.valid_date.active
      render layout: 'show_user'
    end
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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    tmp_params = user_params
    tmp_params[:interests] = tmp_params[:interests].split(',')

    respond_to do |format|
      if @user.update(tmp_params)
        flash[:success_msg] = 'User was successfully updated.'
        format.html { redirect_to edit_user_url(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
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
      #params[:user]
      params.require(:user).permit(:first_name, :last_name, :user_image, :about, :sex, :dob, :from, :interests)
    end
end
