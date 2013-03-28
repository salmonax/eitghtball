require 'spec_helper'

describe Message do
  it {should validate_presence_of :sender}
  it {should validate_presence_of :subject}
  it {should validate_presence_of :body_plain}
  
end