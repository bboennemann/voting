class MyAccountController < ApplicationController
  before_action :authenticate_user!
  layout 'my'

  def index
  	@votings = Voting.where(user_id: current_user.id)
  	render '/votings/index'
  end

end