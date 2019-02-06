module FaaStRuby::SpecHelper
  class Event
    JSON.mapping(
      body: String?,
      headers: Hash(String, String),
      context: String?,
      query_params: Hash(String, String)
    )
  end
  class Response
    @@rendered = false
    property "body"
    property "status"
    property "headers"
    property "io"
    property "binary"
    def initialize(@body : String?, @status : Int32, @headers : Hash(String, String), @binary : Bool = false, @io : Bytes? = nil)
    end

    def initialize(@io : Bytes, @status : Int32, @headers : Hash(String, String), @binary : Bool = true)
    end

    def payload
      if io
        hash = {
          "response" => Base64.encode(io.not_nil!),
          "status" => status,
          "headers" => headers,
          "binary" => binary
        }
      else
        hash = {
          "response" => body,
          "status" => status,
          "headers" => headers,
          "binary" => binary
        }
      end
      hash
    end
  end

  def respond_with(body : String? = nil, status : Int32 = 200, headers : Hash(String, String) = {} of String => String, binary : Bool = false)
    Response.new(body: body, status: status, headers: headers)
  end

  def respond_with(io : Bytes, status : Int32 = 200, headers : Hash(String, String) = {} of String => String, binary : Bool = false)
    Response.new(io: io, status: status, headers: headers, binary: binary)
  end

  def redirect_to(function : String, status : Int32 = 303)
    headers = {"Location" => function}
    Response.new(body: nil, status: status, headers: headers)
  end
  
  def redirect_to(url : String, status : Int32 = 303)
    headers = {"Location" => url}
    Response.new(body: nil, status: status, headers: headers)
  end

  def render(icon : Bytes? = nil, jpeg : Bytes? = nil, gif : Bytes? = nil, png : Bytes? = nil, io : Bytes? = nil, css : String? = nil, svg : String? = nil, js : String? = nil, inline : String? = nil, html : String? = nil, json : String? = nil, yaml : String? = nil, text : String? = nil, status : Int32 = 200, headers : Hash(String, String) = {} of String => String, content_type : String? = nil, binary : Bool = false)
    headers["Content-Type"] = content_type if content_type
    bin = false
    case
    when json
      headers["Content-Type"] ||= "application/json"
      resp_body = json
    when html, inline
      headers["Content-Type"] ||= "text/html"
      resp_body = html
    when text
      headers["Content-Type"] ||= "text/plain"
      resp_body = text
    when yaml
      headers["Content-Type"] ||= "text/yaml"
      resp_body = yaml
    when js
      headers["Content-Type"] ||= "text/javascript"
      resp_body = js
    when io
      headers["Content-Type"] ||= "application/octet-stream"
      bin = binary
      return Response.new(io: io, status: status, headers: headers, binary: bin)
    when png
      headers["Content-Type"] ||= "image/png"
      resp_body = Base64.urlsafe_encode(png, false)
      bin = true
    when svg
      headers["Content-Type"] ||= "image/svg+xml"
      resp_body = svg
    when jpeg
      headers["Content-Type"] ||= "image/jpeg"
      resp_body = Base64.urlsafe_encode(jpeg, false)
      bin = true
    when gif
      headers["Content-Type"] ||= "image/gif"
      resp_body = Base64.urlsafe_encode(gif, false)
      bin = true
    when icon
      headers["Content-Type"] ||= "image/x-icon"
      resp_body = Base64.urlsafe_encode(icon, false)
      bin = true
    when css
      headers["Content-Type"] ||= "text/css"
      resp_body = css
    end
    Response.new(body: resp_body, status: status, headers: headers, binary: bin)
  end
end
