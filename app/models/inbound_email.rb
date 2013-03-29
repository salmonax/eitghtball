class InboundEmail # < ActiveRecord:Base
  include ActiveModel::Validations

  def initialize(attributes={})
    params = {
      :from => 'barfoodicus@barfoo.mailgun.org',
      :to => attributes['sender'],
      :subject => attributes['subject'],
      :text => attributes['stripped-text']
            }

  OutboundEmail.new(params)
  end
end
