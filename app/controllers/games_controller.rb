class GamesController < ApplicationController
  requires_game only: [ :show, :update ]
  
  def new
    game = Game.create
    
    render json: game
  end
  
  def show
    render json: game
  end
  
  def update
    game.board = params[ :game ][ :board ] rescue nil
    
    if game.save
      render json: game
    else
      render json: {
        error: "Error saving game",
        message: "Given board attribute invalid"
      },
      status: 400
    end
  end
end