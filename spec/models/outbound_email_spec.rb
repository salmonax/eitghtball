describe OutboundEmail do
  context '#initialize' do
    let(:mailgun_stub) {stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/inbound_email")}
    let(:outbound_email) { OutboundEmail.new(valid_mailgun_request) }

    it 'initializes with a hash of parameters' do
      mailgun_stub
      outbound_email.should be_an_instance_of OutboundEmail 
    end
    it 'POSTs an email send request.' do
      stub = mailgun_stub
      outbound_email
      stub.should have_been_requested
    end 
  end
end