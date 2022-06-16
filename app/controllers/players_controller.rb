class PlayersController < ApplicationController

    def create
		@player = Player.new(params_player)
		render_response
	end

	def index
		@players = Player.all
		render json: @players
	end

	def show
		@player = Player.find_by(id: params[:id])
		render status: 200, json: @player
	end

	private 
	def params_player
		params.permit(:name, :last_name)
	end

	def render_response
		if @player.save
			render status: 200, json: @player
		else
			render status: 400, json: {message: @player.errors.details} 
		end 	
	end
end
