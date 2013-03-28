class Message # < ActiveRecord:Base
  include ActiveModel::Validations
  attr_accessor :subject, :sender, :body_plain

  validates :subject, :sender, :body_plain, :presence => true

  def initialize(attributes={})
    @sender = attributes['sender']
    @subject = attributes['subject']
    @body_plain = attributes['stripped-text']
    @text = 'This is a standard response text'
  end

  def send_email
    params = {
      :from => 'barfoodicus@barfoo.mailgun.org',
      :to => @sender,
      :subject => @subject,
      :text => @text
        }
    conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter 
    end
    conn.basic_auth('api', 'key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3')
    conn.post("barfoo.mailgun.org/messages", params)
  end

end