class SwaggerController < ApplicationController
  def show
    render file: "./dist/index.html"
  end
end
