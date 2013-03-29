require 'spec_helper'



describe InboundEmailsController do

  context 'routing' do
    it {should route(:post, '/inbound_emails').to :action => :create}
    # it {should route(:post, '/contacts').to :action => :create}
  end

  context 'POST create' do
    context 'with valid_parameters' do    
      before do 

        WebMock::stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/inbound_email")

        post :create, valid_mailgun_request
      end

      it {should respond_with 200}
      it {should respond_with_content_type :json}
    end

    context 'with invalid_parameters' do

    end
  end

end