require "net/http"
require "uri"
require "cuba"
require "thread"

Cuba.define do
  on get, root do
    Thread.new do
      uri = URI.parse("http://check.unblock-us.com")
      Net::HTTP.post_form(uri, {
        "email" => ENV.fetch("UNBLOCK_US_EMAIL"),
        "validated" => "1",
        "rid" => "0"
      })
    end

    res.status = 202
    res.write "Requested"
  end
end

run Cuba
