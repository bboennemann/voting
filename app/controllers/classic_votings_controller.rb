class ClassicVotingsController < ApplicationController
  before_action :set_classic_voting, only: [:show, :edit, :update, :destroy]

  layout 'show_voting', only: [:show]

  def vote_image_item

    user_signed_in? ? user_id = current_user.id : user_id = nil

    @image_item = ImageItem.find(params[:id])
    @image_item.already_voted = @image_item.check_repeat_voting(request.remote_ip, user_id)
    @image_item.vote(request.remote_ip, params[:result], user_id)
    @image_item.save

    @image_item.prepare_display
    
    render :json => @image_item
  end

  def voting
    @voting = Voting.find(params[:classic_voting_id]) 
    if (@voting.audience == 'signed_in' && user_signed_in? == false)
      session[:redirect_path] = request.original_url
      flash[:warning_msg] = 'You need to be signed in for this voting!'
      redirect_to controller: 'devise/sessions', action: 'new', layout: 'canvas'
    else
      render "/classic_votings/votings/#{@voting.item_type}", :layout => 'canvas'
    end
  end


  # GET /classic_votings
  # GET /classic_votings.json
  def index
    @classic_votings = ClassicVoting.all
  end

  # GET /classic_votings/1
  # GET /classic_votings/1.json
  def show
    session[:redirect_path] = request.original_url
    # TODO
    # this must be possible more elegant.
    # this requires all items to be queried twice.
    
    @image_items = ImageItem.where(:voting_id => params[:id]).desc(:score)
    @image_item = ImageItem.new(:voting_id => params[:id])
  end

  # GET /classic_votings/new
  def new
    @classic_voting = ClassicVoting.new
  end

  # GET /classic_votings/1/edit
  def edit
    # TODO
    # this must be possible more elegant.
    # this requires all items to be queried twice.

    @context = 'items'
    session[:redirect_path] = request.original_url
    @image_items = ImageItem.where(:voting_id => params[:id]).desc(:score)
    @image_item = ImageItem.new(:voting_id => params[:id])   
    render :edit, :layout => 'my_account'
  end

  # POST /classic_votings
  # POST /classic_votings.json
  def create
    @classic_voting = ClassicVoting.new(classic_voting_params)

    respond_to do |format|
      if @classic_voting.save
        format.html { redirect_to @classic_voting, notice: 'Classic voting was successfully created.' }
        format.json { render :show, status: :created, location: @classic_voting }
      else
        format.html { render :new }
        format.json { render json: @classic_voting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classic_votings/1
  # PATCH/PUT /classic_votings/1.json
  def update
    respond_to do |format|
      if @classic_voting.update(classic_voting_params)
        format.html { redirect_to @classic_voting, notice: 'Classic voting was successfully updated.' }
        format.json { render :show, status: :ok, location: @classic_voting }
      else
        format.html { render :edit }
        format.json { render json: @classic_voting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classic_votings/1
  # DELETE /classic_votings/1.json
  def destroy
    @classic_voting.destroy
    respond_to do |format|
      format.html { redirect_to classic_votings_url, notice: 'Classic voting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classic_voting
      @voting = Voting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classic_voting_params
      params[:classic_voting]
    end
end
