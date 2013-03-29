class OutboundEmail
  attr_reader :params

  def initialize(params)
    @params = params
    @inbound_text = @params[:text]
    if @inbound_text
      @search_word = select_search_word
      @params[:text] = get_random_twitter
      send_email
    end
  end

  def get_random_twitter
    begin
      response = Faraday.get "http://search.twitter.com/search.json?q=#{@search_word}&page=1&rpp=20"
      parsed = JSON.parse(response.body)
      "Here's what we found for '#{@search_word}': #{parsed['results'].first['text']}"
    rescue
      "Sorry, Twitter is being a piece of crap. But go ahead and try again."
    end
  end

private

  def select_search_word
    crappy_words = %w(what where when then than there this that)
    good_words = @inbound_text.downcase.split(' ').map { |word| word unless word.gsub(/[^\w]/,'').length <= 3 }.compact
    unless good_words == nil || good_words.empty?
      good_words = good_words - crappy_words
      return good_words[rand(good_words.length)].gsub(/[^\w]/,'') unless good_words.empty?
    end
    "error"
  end

  def send_email
    conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter 
    end
    conn.basic_auth('api', 'key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3')
    conn.post("barfoo.mailgun.org/messages", params)
  end
end