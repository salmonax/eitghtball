require 'spec_helper'
require 'webmock/rspec'

VALID_RESPONSE = {"recipient"=>"barfoodicus@barfoo.mailgun.org", "sender"=>"mfpiccolo@gmail.com", "subject"=>"pry test", "from"=>"Mike Piccolo <mfpiccolo@gmail.com>", "Received"=>"by 10.52.164.235 with HTTP; Thu, 28 Mar 2013 13:58:12 -0700 (PDT)", "X-Envelope-From"=>"<mfpiccolo@gmail.com>", "Dkim-Signature"=>"v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113; h=mime-version:x-received:date:message-id:subject:from:to :content-type; bh=UebXZU9ChBeHfUxEjvgXf7NPMonvV6sbmhFxNCJnMm4=; b=hm3hH7yw0W5M7lm8mcoUhwFU6AV4DEX594VtJKa3/6jquz1B/JsdeJS6Msv6F6J9TE Dl4RtMB8CuxYTQwibYzcfXH/Pbckwv5BbmflRPACDZz5pj2gdj5lvd1U1Sx/LnjAr6/N CNvRkeZg90L+FUUWjsB8fyGUs8rgQywUk8COa0qao9jsBr4YllxuSgtU3nq7rrjI5anU vVmo7TcFRfBPnawnFg7uCZo0snTlTJMsFzZNJqU7RLI+/SiH2Kywfnb2bFAzEArSAQTP ooUDMAteTDrOcG3H90ojaoSRy9F7TqSzu0wWIYCUeiI/vw4+KIkh38hD5wRc8oWoKdgU eWKw==", "Mime-Version"=>"1.0", "X-Received"=>"by 10.52.75.65 with SMTP id a1mr30652vdw.79.1364504292325; Thu, 28 Mar 2013 13:58:12 -0700 (PDT)", "Date"=>"Thu, 28 Mar 2013 13:58:12 -0700", "Message-Id"=>"<CAOKM954qHm_i99p1Uz=PB5xZzikSXgF++a++bNivY572aJWYuw@mail.gmail.com>", "Subject"=>"pry test", "From"=>"Mike Piccolo <mfpiccolo@gmail.com>", "To"=>"barfoodicus@barfoo.mailgun.org", "Content-Type"=>"multipart/alternative; boundary=\"20cf3071cf72a37fda04d90269b0\"", "X-Mailgun-Incoming"=>"Yes", "message-headers"=>"[[\"Received\", \"by luna.mailgun.net with SMTP mgrt 8784072445969; Thu, 28 Mar 2013 20:58:14 +0000\"], [\"X-Envelope-From\", \"<mfpiccolo@gmail.com>\"], [\"Received\", \"from mail-ve0-f171.google.com (mail-ve0-f171.google.com [209.85.128.171]) by mxa.mailgun.org with ESMTP id 5154aee4.6edd4f0-in3; Thu, 28 Mar 2013 20:58:12 -0000 (UTC)\"], [\"Received\", \"by mail-ve0-f171.google.com with SMTP id b10so8519878vea.16 for <barfoodicus@barfoo.mailgun.org>; Thu, 28 Mar 2013 13:58:12 -0700 (PDT)\"], [\"Dkim-Signature\", \"v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113; h=mime-version:x-received:date:message-id:subject:from:to :content-type; bh=UebXZU9ChBeHfUxEjvgXf7NPMonvV6sbmhFxNCJnMm4=; b=hm3hH7yw0W5M7lm8mcoUhwFU6AV4DEX594VtJKa3/6jquz1B/JsdeJS6Msv6F6J9TE Dl4RtMB8CuxYTQwibYzcfXH/Pbckwv5BbmflRPACDZz5pj2gdj5lvd1U1Sx/LnjAr6/N CNvRkeZg90L+FUUWjsB8fyGUs8rgQywUk8COa0qao9jsBr4YllxuSgtU3nq7rrjI5anU vVmo7TcFRfBPnawnFg7uCZo0snTlTJMsFzZNJqU7RLI+/SiH2Kywfnb2bFAzEArSAQTP ooUDMAteTDrOcG3H90ojaoSRy9F7TqSzu0wWIYCUeiI/vw4+KIkh38hD5wRc8oWoKdgU eWKw==\"], [\"Mime-Version\", \"1.0\"], [\"X-Received\", \"by 10.52.75.65 with SMTP id a1mr30652vdw.79.1364504292325; Thu, 28 Mar 2013 13:58:12 -0700 (PDT)\"], [\"Received\", \"by 10.52.164.235 with HTTP; Thu, 28 Mar 2013 13:58:12 -0700 (PDT)\"], [\"Date\", \"Thu, 28 Mar 2013 13:58:12 -0700\"], [\"Message-Id\", \"<CAOKM954qHm_i99p1Uz=PB5xZzikSXgF++a++bNivY572aJWYuw@mail.gmail.com>\"], [\"Subject\", \"pry test\"], [\"From\", \"Mike Piccolo <mfpiccolo@gmail.com>\"], [\"To\", \"barfoodicus@barfoo.mailgun.org\"], [\"Content-Type\", \"multipart/alternative; boundary=\\\"20cf3071cf72a37fda04d90269b0\\\"\"], [\"X-Mailgun-Incoming\", \"Yes\"]]", "timestamp"=>"1364504900", "token"=>"92ckc5wey1krvjt2k-x8z0mf9n3e2lux-11jgrbecmoimi3ll8", "signature"=>"949205e439a4032f9fb61d264d665eddb2035775fb21d4ccb82d087ed9e1eda9", "body-plain"=>"pry testing!!!!\r\n", "body-html"=>"pry testing!!!!\r\n", "stripped-html"=>"pry testing!!!!\r\n", "stripped-text"=>"pry testing!!!!", "stripped-signature"=>"", "action"=>"process_request", "controller"=>"messages"}


describe Message do
  context 'validations' do
    it {should validate_presence_of :sender}
    it {should validate_presence_of :subject}
    it {should validate_presence_of :body_plain}
  end

  context '#send_email' do
    it 'POSTs an email send request.' do
      stub = stub_request(:post, "https://api:key-4tcw-c9e6mk4qk4c5br9so2odsksp-y3@api.mailgun.net/v2/barfoo.mailgun.org/messages")
      message = Message.new(VALID_RESPONSE)
      message.send_email
      stub.should have_been_requested
    end
  end
end