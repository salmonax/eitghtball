class MessagesController < ApplicationController

  def process_request
    # if params == nil
    #   puts "Uh oh!"
    # else
    #   p params
    # end

    message = Message.new(params['message'])
    render :json => message

    message.send_email
  end

end