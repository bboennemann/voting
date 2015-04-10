class CategoriesController < ApplicationController
	
	def index
		render :index, layout: nil
	end
end