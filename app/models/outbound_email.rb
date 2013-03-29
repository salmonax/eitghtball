class OutboundEmail
  attr_reader :params

  def initialize(params)
    #binding.pry
    @params = params
    @inbound_text = @params[:text]
    if @inbound_text
      @search_word = @inbound_text.split(' ')[rand(@inbound_text.split(' ').length)].gsub(/[^\w]/,'')
      @params[:text] = get_random_twitter
      send_email
    end
  end

  def get_random_twitter
    #binding.pry
     response = Faraday.get(:url => "http://search.twitter.com/search.json?q=#{@search_word}&page=1&rpp=1")
     parsed = JSON.parse(response.body)
     parsed['results'].first['text']
  end

private

  def send_email
    conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter 
    end
    conn.basic_auth('api', 'key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3')
    conn.post("barfoo.mailgun.org/messages", params)
  end
end