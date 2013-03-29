class InboundEmailsController < ApplicationController

  def create
    inbound_email = InboundEmail.new(params)
    render :json => inbound_email
  end
end