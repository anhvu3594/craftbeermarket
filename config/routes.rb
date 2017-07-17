Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
end
