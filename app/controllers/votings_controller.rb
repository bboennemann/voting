class VotingsController < ApplicationController
  before_action :set_voting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[ :edit, :update, :destroy]

  layout 'canvas', only: [:new, :create]

  layout 'my', only: [:edit]

  # GET /votings
  # GET /votings.json
  def index
    @votings = Voting.all
  end

  # GET /votings/1
  # GET /votings/1.json
  def show
  end

  # GET /votings/new
  def new
        @voting = Voting.new
  end

  # GET /votings/1/edit
  def edit
  end

  # POST /votings
  # POST /votings.json
  def create
    @voting = Voting.new(voting_params)

    @voting.user_id = current_user.id
    @voting.voting_type = session[:new_voting_type]
    @voting.item_type = session[:new_voting_item_type]

    respond_to do |format|
      if @voting.save
        flash[:success_msg]  = "Congratulations! Here is your shiny new voting! Now go and add some #{@voting.item_type.pluralize}"
        format.html { redirect_to "/votings/#{@voting._id}/#{@voting.item_type}_items/new" }
        format.json { render :show, status: :created, location: @voting }
      else
        format.html { render :new }
        format.json { render json: @voting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votings/1
  # PATCH/PUT /votings/1.json
  def update
    respond_to do |format|
      if @voting.update(voting_params)
        format.html { redirect_to @voting, notice: 'Voting was successfully updated.' }
        format.json { render :show, status: :ok, location: @voting }
      else
        format.html { render :edit }
        format.json { render json: @voting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votings/1
  # DELETE /votings/1.json
  def destroy
    @voting.destroy
    respond_to do |format|
      format.html { redirect_to votings_url, notice: 'Voting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voting
      @voting = Voting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_params
      #params[:voting]
      params.require(:voting).permit(:title, :description, :audience, :contribution, :searchable, :active)
    end

end
