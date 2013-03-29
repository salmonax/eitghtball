class InboundEmailsController < ApplicationController

  def create

    inbound_email = InboundEmail.new(params)
    render :json => inbound_email

    send_email(inbound_email)
  end

  def send_email(inbound_email)
    OutboundEmail.new(inbound_email.params)
  end

end