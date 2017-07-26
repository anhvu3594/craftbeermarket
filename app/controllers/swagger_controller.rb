class SwaggerController < ApplicationController
  def show
    render file: "./app/swagger/index.html"
  end
end
