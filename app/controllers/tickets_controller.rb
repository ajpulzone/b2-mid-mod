class TicketsController < ApplicationController

  def create

  end

  
  private
  def ticket_params
    params.permit(:id, :subject, :age)
  end
end