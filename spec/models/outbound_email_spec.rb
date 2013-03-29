describe OutboundEmail do

  let(:mailgun_stub) {stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/messages").to_return(:body => valid_mailgun_request)}
  let(:outbound_email) {OutboundEmail.new(InboundEmail.new(valid_mailgun_request).params)}
  let(:twitter_stub) {stub_request(:get, "http://search.twitter.com/search.json?q=testing&page=1&rpp=20").to_return(:body => valid_twitter_request)}

  context '#initialize' do
    
    it 'initializes with a hash of parameters' do
      twitter_stub
      mailgun_stub
      outbound_email.should be_an_instance_of OutboundEmail 
    end
    it 'POSTs an email send request' do
      twitter_stub
      stub = mailgun_stub
      outbound_email
      stub.should have_been_requested
    end

    it 'GETs a random tweet based on input' do
      # binding.pry
      stub = twitter_stub
      mailgun_stub 
      outbound_email
      stub.should have_been_requested
    end
  end

end