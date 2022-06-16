class Game < ApplicationRecord
    before_create :set_state
    before_create :set_board_plays

    def set_state
        self.game_state = true
    end

    def set_board_plays
        self.board_plays = "UUUUUUUUU"
    end


end
