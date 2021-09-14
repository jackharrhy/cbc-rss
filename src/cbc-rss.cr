require "http/client"
require "xml"

require "kemal"

module CbcRss
  VERSION = "0.1.0"

  TOP_STORIES = "https://www.cbc.ca/cmlink/rss-topstories"
end


get "/" do
  response = HTTP::Client.get(CbcRss::TOP_STORIES)
  text = response.body.to_s
  document = XML.parse(text)

  authors = document.xpath_nodes("//author")

  authors.each do |author|
    if author.children.size == 0
      author.content = "Unknown"
    end
  end

  document.to_s
end

Kemal.run
