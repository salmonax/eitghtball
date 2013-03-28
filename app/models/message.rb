class Message # < ActiveRecord:Base
  include ActiveModel::Validations
  attr_accessor :subject, :sender, :body_plain

  validates :subject, :sender, :body_plain, :presence => true

  def initialize(attributes={})
    puts attributes
    @address = attributes['sender']
    @subject = attributes['subject']
    @body_plain = attributes['body-plain']
  end

end