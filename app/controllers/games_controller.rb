class GamesController < ApplicationController
    def create
        @player = Player.find_by(token: params[:player_token])
		@game = Game.find_by(token: params[:token], game_state: true)
        if @game.blank?
            @game = Game.new(token: params[:token], player_1_id: @player.id)
            render_response
        else
            if @player.id != @game.player_1_id
                @game.assign_attributes(player_2_id: @player.id, turn: 2)
                render_response
            else
                render status: 400, json: {message: "La partida ya pertenece a este jugador"}              
            end
        end
    end

	def index
		@games = Game.all
		render json: @games
	end
    
    def checkGame
		@game = Game.find_by(id: params[:id], game_state: true)
        render json: @game
	end

    def show
        @game = Game.find_by(id: params[:id], game_state: true)
        if @game.blank? 
            render status: 404, json:{ msg: "No se encontró el juego solicitado"}
        else
            render json: @game
        end
    end

    def update
        @game = Game.find_by(token: params[:token], game_state: true)
        if @game.blank?
            render status: 400, json: {message: "Partida no encontrada."}
        else
            if params[:game_play]
                set_plays
                @game.assign_attributes(turn: @game.turn == 2 ? 1 : 2, winner: params[:winner])
                render_response
            else
                @game.assign_attributes(game_state: false)
                render_response
            end
        end
    end

    private 
	def params_game
		params.permit(:token, :player_1_id, :player_2_id, :player_token, :game_state, :play, :game_play, :winner)
	end

	def render_response
		if @game.save
			render status: 200, json: {game: @game}
		else
            
			render status: 400, json: {message: @game.errors.details} 
		end 	
	end

    def set_plays
        if @game.turn == 1
            @game.board_plays[params[:game_play]] = "X" 
        else
            @game.board_plays[params[:game_play]] = "O"            
        end
    end
end
