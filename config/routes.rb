Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/api/ping", to: "application#ping"

  post "/api/registerDevice", to: "device#register"
  post "/api/authenticate", to: "device#authenticate"


  get "/api/documents/:type/:collection", to: "document#index"
  get "/api/documents/:type/:collection/:search", to: "document#index"
  patch "/api/document/:id", to: "document#patch"
  post "/api/document", to: "document#new"
  post "/api/documentExists", to: "document#exists"

  post "/api/collections", to:"collection#index"
  post "/api/collection", to:"collection#new"

  post "/api/import_bookmark", to:"bookmark#import"
  get "/api/import_bookmark/:request_id", to:"bookmark#import_status"
end
