module CheckWinner
  include WinningIndices
  
  def check_winning_indices( board, turn )
    if board[ 1 ][ 1 ] == turn
      game_won = check_index_groups( board, turn, :center )
      
      return game_won if game_won
    end
    
    check_index_groups( board, turn, :rows_and_columns )
  end
  
  private
  
  def check_index_groups( board, turn, group )
    result = nil
    index  = 0
    
    while !result && index < WINNING_INDICES[ group ].length
      index_group = WINNING_INDICES[ group ][ index ]

      if check_by_index( board, index_group, turn )
        result = index_group
      end
      
      index += 1
    end
    
    result
  end
  
  def check_by_index( board, indices, turn )
    indices.each do | index_array |
      return false unless board[ index_array[ 0 ] ][ index_array[ 1 ] ] == turn
    end
    
    true
  end
end