class VotingWizardsController < ApplicationController

  layout 'canvas'

  # GET /voting_wizards
  # GET /voting_wizards.json
  def step1
        render 'voting_wizards/item_type'
  end

  def step2

    # saving the item type in session in order to have them available in case of later redirect
    session[:new_voting_item_type] = params[:item_type]

    # HINT: different item types allow for different voting types
    # create a partial according to the following naming convention for item option:
    # <item_types>_item_votings
    render "/voting_wizards/#{params[:item_type]}_item_votings"
  end

  def step3
    # saving the voting type in session in order to have them available in case of later redirect
    session[:new_voting_type] = params[:voting_type]

    if user_signed_in?
      redirect_to controller: :votings, action: :new
    else
      session[:redirect_path] = '/voting_wizards/step3'
      flash[:warning_msg] = 'You need to be logged in to create a new voting!'
      redirect_to controller: 'devise/sessions', action: 'new', layout: 'canvas'
    end
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_wizard_params
      params[:voting_wizard]
    end
end
