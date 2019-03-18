module RequiresGameFilter
  class RequiresGame
    def before( controller )
      result = false
      
      game = Game.find_by( id: controller.params[ :game_id ] )

      if game.present?
        controller.define_singleton_method( 'game' ) do
          game
        end
        
        result = true
      else
        controller.redirect_to controller: 'errors', action: 'not_found'
      end

      result
    end
  end

  module ClassMethods
    def requires_game( options = {} )
      before_action( RequiresGame.new, options );
    end
  end

  def self.included( controller )
    controller.extend( ClassMethods )
  end
end