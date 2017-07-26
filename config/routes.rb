Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'swagger', to: 'swagger#show'
  # match  'swagger1' => "application#index.html" via: [:get]
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
end
