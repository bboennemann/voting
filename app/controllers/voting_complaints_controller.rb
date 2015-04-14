class VotingComplaintsController < ApplicationController
  before_action :set_voting_complaint, only: [:show, :edit, :update, :destroy]

  layout 'canvas'

  # GET /voting_complaints
  # GET /voting_complaints.json
  def index
    @voting_complaints = VotingComplaint.all
  end

  # GET /voting_complaints/1
  # GET /voting_complaints/1.json
  def show
  end

  # GET /voting_complaints/new
  def new
    @voting_complaint = VotingComplaint.new
    @voting = Voting.find(params[:voting_id])
  end

  # GET /voting_complaints/1/edit
  def edit
  end

  # POST /voting_complaints
  # POST /voting_complaints.json
  def create
    @voting_complaint = VotingComplaint.new(voting_complaint_params)

    respond_to do |format|
      if @voting_complaint.save
        format.html { redirect_to @voting_complaint, notice: 'Voting complaint was successfully created.' }
        format.json { render :show, status: :created, location: @voting_complaint }
      else
        format.html { render :new }
        format.json { render json: @voting_complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voting_complaints/1
  # PATCH/PUT /voting_complaints/1.json
  def update
    respond_to do |format|
      if @voting_complaint.update(voting_complaint_params)
        format.html { redirect_to @voting_complaint, notice: 'Voting complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @voting_complaint }
      else
        format.html { render :edit }
        format.json { render json: @voting_complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voting_complaints/1
  # DELETE /voting_complaints/1.json
  def destroy
    @voting_complaint.destroy
    respond_to do |format|
      format.html { redirect_to voting_complaints_url, notice: 'Voting complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voting_complaint
      @voting_complaint = VotingComplaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_complaint_params
      params[:voting_complaint]
    end
end
