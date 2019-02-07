require "./spec_helper"

private def event_hash
  {
    "body" => nil,
    "context" => nil,
    "headers" => {"Content-Type" => "application/json"},
    "query_params" => {} of String => String
  }
end

private def event
  Event.from_json(event_hash.to_json)
end

describe "handler(event)" do
  it "should return String" do
    body = handler(event).body
    body.should be_a String
  end

  it "should say Hello, World!" do
    event = Event.from_json(event_hash.to_json)
    body = handler(event).body
    body.should eq("Hello, World!\n")
  end
end
