class MessagesController < ApplicationController

  def process_request
    message = Message.new(params[:message])
    render :json => message


  end

end