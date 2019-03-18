class ErrorsController < ApplicationController
  def not_found
    render json: { 
      error: "not-found", 
      error_message: "The requested path was not found"
    },
    status: 404
  end
  
  def exception
    render json: { 
      error: "internal-server-error", 
      error_message: "An unexpected error occurred"
    },
    status: 500
  end
end