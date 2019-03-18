class Game < ApplicationRecord
  include CheckWinner
  
  validate :validate_board
  validate :validate_no_winner
  
  after_validation :update_game
  
  private
  
  def validate_board
    if !board.is_a?( Array ) || board.length != 3 || !validate_board_attributes
      errors.add( :board, "Given board attribute invalid" )
      
      return false
    end
  end
  
  def validate_board_attributes
    board.each do | column |
      return false if !column.is_a?( Array ) || column.length != 3
      
      column.each do | mark |
        return false if !mark.is_a?( String ) || mark.length != 1 || ![ "-", "X", "O" ].include?( mark )
      end
    end
    
    true
  end
  
  def validate_no_winner
    if winner
      errors.add( :board, "This game has been completed" )
      
      return false
    end
  end
  
  def update_game
    self.turn_count += 1
    
    if self.turn_count >= 5
      self.winning_coordinates = check_winning_indices( self.board, self.turn )
      
      if self.winning_coordinates
        self.winner = self.turn
      end
      
      if self.turn_count == 9
        self.winner = "draw" unless self.winner
      end
      
      if self.winner
        self.wins_x = Game.where( winner: "X" ).count
        self.wins_o = Game.where( winner: "O" ).count
        self.draws  = Game.where( winner: "draw" ).count
        
        iterate_winner_count
      end
    end
    
    
    self.turn = self.turn == "X" ? "O" : "X" unless self.winner
  end
  
  def iterate_winner_count
    case self.winner
    when "O"
      self.wins_o += 1
    when "X"
      self.wins_x += 1
    else
      self.draws += 1
    end
  end
end
