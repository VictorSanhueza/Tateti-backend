class PlayersController < ApplicationController
    def create
		@player = Player.new(params_player)
		render_response
	end

	def index
		@players = Player.all
		render json: @players
	end

	private 
	def params_player
		params.permit(:name, :last_name)
	end

	def render_response
		if @player.save
			render status: 200, json: {player: @player}
		else
			render status: 400, json: {message: @player.errors.details} 
		end 	
	end
end
