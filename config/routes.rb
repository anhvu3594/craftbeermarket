Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'swagger_doc_v1', to: 'swagger#show_api_doc_v1'
  get 'swagger_doc_v2', to: 'swagger#show_api_doc_v2'
  get 'send_message', to: 'chat#send_message'
  # match  'swagger1' => "application#index.html" via: [:get]
  mount API::Base, at: '/'
  mount GrapeSwaggerRails::Engine, at: '/documentation'
  mount ActionCable.server => '/cable'
end
