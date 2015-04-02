class ImageItemsController < ApplicationController
  before_action :set_image_item, only: [:show, :edit, :update, :destroy]

  layout 'canvas', only: [:new, :create]

  # GET /image_items
  # GET /image_items.json
  def index
    @image_items = ImageItem.all
  end

  # GET /image_items/1
  # GET /image_items/1.json
  def show
  end

  # GET /image_items/new
  def new

    if user_signed_in? == false
      session[:redirect_path] = request.original_url
      flash[:warning_msg] = 'You need to be logged in to add an image!'
      redirect_to controller: 'devise/sessions', action: 'new', layout: 'canvas'
    end

    @voting = Voting.find(params[:voting_id])
    @image_item = ImageItem.new(:voting_id => params[:voting_id])
  end

  # GET /image_items/1/edit
  def edit
  end

  # POST /image_items
  # POST /image_items.json
  def create

    @voting = Voting.find(image_item_params[:voting_id])

    image_item_params[:image_file].each do |file|
      image_item = @voting.image_items.create(:voting_id => image_item_params[:voting_id], :image_file => file, :user_id => current_user.id, created_at: DateTime.now )
      @voting.items << image_item.id
    end
    @voting.save

    respond_to do |format|
#      if @image_item.save
        #format.html { redirect_to @voting, notice: 'Image item was successfully created.' }
        format.html { render '/votings/_item_added', notice: 'Image item was successfully created.' }
        format.json { render :show, status: :created, location: @image_item }
#      else
#        format.html { render :new }
#        format.json { render json: @image_item.errors, status: :unprocessable_entity }
#      end
    end
  end

  # PATCH/PUT /image_items/1
  # PATCH/PUT /image_items/1.json
  def update
    respond_to do |format|
      if @image_item.update(image_item_params)
        format.html { redirect_to @image_item, notice: 'Image item was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_item }
      else
        format.html { render :edit }
        format.json { render json: @image_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_items/1
  # DELETE /image_items/1.json
  def destroy
    @image_item.destroy
    respond_to do |format|
      format.html { redirect_to session[:redirect_path] , notice: 'Image item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_item
      @image_item = ImageItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_item_params
      #params[:image_item]
      params.require(:image_item).permit(:voting_id, :description, :image_file => [])
    end
end
