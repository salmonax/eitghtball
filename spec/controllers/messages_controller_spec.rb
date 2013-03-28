require 'spec_helper'

describe MessagesController do
  context 'routing' do
    it {should route(:post, '/messages').to :action => :process_request}
  end

  context 'POST process_request' do
    context 'with valid_parameters' do
      let(:valid_attributes) {{"sender"=>"mfpiccolo@gmail.com", "subject"=>"you suck", "stripped-text"=>"nope"}}
      let(:valid_parameters) {{message: valid_attributes}}

      before {post :process_request, valid_parameters}

      it {should respond_with 200}
      it {should respond_with_content_type :json}
    end

    context 'with invalid_parameters' do

    end
  end

end