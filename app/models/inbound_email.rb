class InboundEmail # < ActiveRecord:Base
  include ActiveModel::Validations
  attr_accessor :params

  def initialize(attributes={})

    @params = {
      :from => 'barfoodicus@barfoo.mailgun.org',
      :to => attributes['sender'],
      :subject => attributes['subject'],
      :text => attributes['stripped-text']
            }
  end
end