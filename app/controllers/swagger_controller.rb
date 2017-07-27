class SwaggerController < ApplicationController
  def show_api_doc_v1
    render file: "./public/swagger/swagger_doc_v1.html"
  end
  def show_api_doc_v2
    render file: "./public/swagger/swagger_doc_v2.html"
  end
end
