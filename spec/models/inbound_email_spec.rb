require 'spec_helper'
require 'webmock/rspec'

describe InboundEmail do

  context '#initialize' do
    it 'initializes with attributes' do 
      InboundEmail.new({}).should be_an_instance_of InboundEmail
    end

    it 'initializes an instance of OutBound email' do
      OutboundEmail.should_receive(:new)
      InboundEmail.new({})
    end
  end

  # context 'readers' do
  #   it 'returns the parameters' do
  #     params = {:from => 'barfoodicus@barfoo.mailgun.org', :to => 'mfpiccolo@gmail.com', :subject => 'test', :text => 'testing!!!!'}
  #     InboundEmail.new(valid_mailgun_request).params.should eq params
  #   end
  # end
end