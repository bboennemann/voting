class MyAccountController < ApplicationController
  before_action :authenticate_user!
  layout 'my_account'

  def index
  	@user = User.find(current_user)
  	@votings = Voting.where(user_id: current_user.id)
  end

end