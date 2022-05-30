class GamesController < ApplicationController
    def create
		@game = Game.new(params_game)
		render_response
	end

	def index
        debugger
		@games = Game.all
		render json: @games
	end

    def show
        debugger
        @game = Game.find_by(token: params[:token])
        if @game.blank? 
            @game = Game.new(params_game)
        else
            @game.assign_attributes(player_2_id: params[:player_1_id])
            if @game.save
                render status: 200, json: {job: @game}
            else
                render status: 400, json: {message: @game.errors.details} 
            end
        end
    end

    private 
	def params_game
		params.permit(:token, :player_1_id)
	end

	def render_response
		if @game.save
			render status: 200, json: {player: @game}
		else
			render status: 400, json: {message: @game.errors.details} 
		end 	
	end
end
