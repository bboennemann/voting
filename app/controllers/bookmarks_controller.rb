class BookmarksController < ApplicationController
  before_action :authenticate_user!

  layout 'my_account'

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @votings = Voting.find(current_user.bookmarks)
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create

    unless current_user.bookmarks.include?(params[:voting_id].to_s)
      voting = Voting.find(params[:voting_id])
      voting.inc(bookmarks: 1)
      current_user.bookmarks << params[:voting_id]        
    end

    respond_to do |format|
      if current_user.save && voting.save
        #format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { head :no_content}
      else
        #format.html { render :new }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy

    voting = Voting.find(params[:voting_id])
    voting.bookmarks = voting.bookmarks - 1
    current_user.bookmarks.delete(params[:voting_id])

    
    respond_to do |format|
      if current_user.save && voting.save
        #format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { head :no_content}
      else
        #format.html { render :new }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params[:bookmark]
    end
end
