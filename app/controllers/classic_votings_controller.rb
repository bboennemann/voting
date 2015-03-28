class ClassicVotingsController < ApplicationController
  before_action :set_classic_voting, only: [:show, :edit, :update, :destroy]

  # GET /classic_votings
  # GET /classic_votings.json
  def index
    @classic_votings = ClassicVoting.all
  end

  # GET /classic_votings/1
  # GET /classic_votings/1.json
  def show
  end

  # GET /classic_votings/new
  def new
    @classic_voting = ClassicVoting.new
  end

  # GET /classic_votings/1/edit
  def edit
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
