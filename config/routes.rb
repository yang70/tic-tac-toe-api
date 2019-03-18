Rails.application.routes.draw do
  get   '/new_game',       to: 'games#new'
  get   '/games/:game_id', to: 'games#show'
  patch '/games/:game_id', to: 'games#update'
  
  get "/404" => "errors#not_found"
  get "/500" => "errors#exception"
end
