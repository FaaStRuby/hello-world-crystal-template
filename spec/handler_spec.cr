require "./spec_helper"

describe "handler(event)" do
  event_hash = {
    "body" => nil,
    "context" => nil,
    "headers" => {"Content-Type" => "application/json"},
    "query_params" => {} of String => String
  }
  event = Event.from_json(event_hash.to_json)

  it "should return String" do
    body = handler(event).body
    body.class.should eq(String)
  end
  it "should say Hello, World!" do
    event_hash["body"] = nil
    event = Event.from_json(event_hash.to_json)
    body = handler(event).body
    body.should eq("Hello, World!\n")
  end
end
