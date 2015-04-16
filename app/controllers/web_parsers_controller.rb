class WebParsersController < ApplicationController
  before_action :set_web_parser, only: [:show, :edit, :update, :destroy]

  # GET /web_parsers
  # GET /web_parsers.json
  def index
    @web_parsers = WebParser.all
  end

  # GET /web_parsers/1
  # GET /web_parsers/1.json
  def show
  end

  # GET /web_parsers/new
  def new
    @web_parser = WebParser.new
  end

  # GET /web_parsers/1/edit
  def edit
  end

  # POST /web_parsers
  # POST /web_parsers.json
  def create
    @web_parser = WebParser.new
    @images = web_parser.get_images web_parser_params[:website_url]
    render :show
  end

  # PATCH/PUT /web_parsers/1
  # PATCH/PUT /web_parsers/1.json
  def update
    respond_to do |format|
      if @web_parser.update(web_parser_params)
        format.html { redirect_to @web_parser, notice: 'Web parser was successfully updated.' }
        format.json { render :show, status: :ok, location: @web_parser }
      else
        format.html { render :edit }
        format.json { render json: @web_parser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_parsers/1
  # DELETE /web_parsers/1.json
  def destroy
    @web_parser.destroy
    respond_to do |format|
      format.html { redirect_to web_parsers_url, notice: 'Web parser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_parser
      @web_parser = WebParser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def web_parser_params
      require.params(:web_parser).permit(:website_url)
    end
end
