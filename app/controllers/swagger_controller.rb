class SwaggerController < ApplicationController
  def show
    render file: "./swagger/index.html"
  end
end
