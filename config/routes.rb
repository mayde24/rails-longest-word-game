Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/start", to: "game#start"
  post "/result", to: "game#result"
end
