# require "cool-shard"
require "json"

# To deploy this function, cd into its folder and run:
# faastruby deploy-to WORKSPACE_NAME
def handler(event : FaaStRuby::Event) : FaaStRuby::Response
  # event.body : String | Nil
  # event.headers : Hash(String, String)
  # event.context : String | Nil
  # query_params : Hash(String, String)
  # FUNCTION RESPONSE
  #
  # You can render text, json, yaml, html or js. Example:
  # render html: "<p>Hello World!</p>"
  # render yaml: {"hello" => "world!"}
  #
  # Status:
  # The default status is 200. You can set a custom status like this:
  # render json: {"error" => "Could not perform the action"}, status: 422
  #
  # Headers:
  # The 'Content-Type' header is automatically set when you use 'render'.
  # You can set custom headers using a Hash(String, String). Example:
  # render text: "It Works!", headers: {"TransactionId" => 23928}
  render text: "Hello, World!\n"
end
