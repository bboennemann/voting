class VotingsController < ApplicationController
  before_action :set_voting, only: [:show, :edit, :update, :destroy, :delete]
  before_action :authenticate_user!, only:[:new, :create, :destroy]

  

  # GET /votings
  # GET /votings.json
  def index
    if params[:tags]
      @votings = Voting.where(:tags => params[:tags]).general_audience.valid_date.active
    elsif params[:category]
      @votings = Voting.in(:tags => Category::LIST[params[:category]]).general_audience.valid_date.active
    else
      @votings = Voting.general_audience.valid_date.active
    end

  end

  # GET /votings/1
  # GET /votings/1.json
  def show
  end

  # GET /votings/new
  def new
    @voting = Voting.new
    render layout: "canvas"
  end

  # GET /votings/1/edit
  def edit
    @context = 'settings'
    is_current_user? @voting.user_id
    render layout: 'my_account'
  end

  # POST /votings
  # POST /votings.json
  def create

    tmp_params = voting_params
    tmp_params[:tags] = tmp_params[:tags].split(',')


    @voting = Voting.new(tmp_params)

    @voting.user_id = current_user.id
    @voting.voting_type = session[:new_voting_type]
    @voting.item_type = session[:new_voting_item_type]

    respond_to do |format|
      if @voting.save
        flash[:success_msg]  = "Congratulations! Here is your shiny new voting! Now go and add some #{@voting.item_type.pluralize}"
        format.html { redirect_to "/votings/#{@voting._id}/#{@voting.item_type}_items/new" }
        format.json { render :show, status: :created, location: @voting, layout: "canvas" }
      else
        format.html { render :new }
        format.json { render json: @voting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votings/1
  # PATCH/PUT /votings/1.json
  def update

    tmp_params = voting_params
    tmp_params[:tags] = tmp_params[:tags].split(',')
    

    respond_to do |format|
      if @voting.update(tmp_params)
        flash[:success_msg] = 'Voting was successfully updated.'
        format.html { render :edit, layout: 'my_account' }
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

    if voting_params[:confirm_code_check] != voting_params[:confirm_code]
      logger.debug voting_params[:confirm_code]
      logger.debug voting_params[:confirm_code_check]
      flash[:error_msg] = "Please make sure to enter the correct confirmation code"
      redirect_to "/votings/#{@voting.id}/delete", layout: 'my_account'
    else

      @voting.destroy
      respond_to do |format|
        format.html { redirect_to '/my_account', flash[:success_msg] => 'Voting was successfully destroyed.' }
        format.json { head :no_content }
      end

    end
    

  end


  def delete
    @context = 'delete'
    @confirm_code = ('a'..'z').to_a.shuffle[0,8].join
    render layout: 'my_account'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voting
      @voting = Voting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_params
      #params[:voting]
      params.require(:voting).permit(:title, :description, :audience, :contribution, :searchable, :active, :tags, :confirm_code, :confirm_code_check, :online_from, :online_to)
    end

end
