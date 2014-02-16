class HealthcareController < ApplicationController
  require 'faraday'
  require 'logger'
  def index
    #api = HealthCare::Client.new
    # Find restaurants
    resp_text="%&<?xml version='1.0' encoding='UTF-8'?>
<PrivateOptionsAPIRequest>
	<ProductDetailsForSmallGroupRequest>
		<ProductIDs>
			<ProductID>38927UT015</ProductID>
		</ProductIDs>
	</ProductDetailsForSmallGroupRequest>
</PrivateOptionsAPIRequest>&"
    #resp = api.publicOptions(resp_text)
    #@data=JSON.parse(resp)
    #@count=@data['total_entries']
    #@page=@data['current_page']
    #@restaurants=@data['restaurants']
    myUrl="http://api.finder.healthcare.gov/v2.0"
    conn = Faraday.new(:url=> myUrl) do |builder|
      conn.post '/PrivateOption',resp_text
      builder.response :logger #logging stuff
      builder.use Faraday::Adapter::NetHttp #default adapter for Net::HTTP
    end

    res = conn.post do |request|
      request.url myUrl
      request.body = resp_text
    end

    puts res.body
  end

  module HealthCare
    class Error < StandardError ; end

    module Request
      API_BASE = "http://api.finder.healthcare.gov/v2.0/"

      def connection
        connection = Faraday.new(API_BASE) do |c|
          c.use (Faraday::Request::UrlEncoded)
          c.use (Faraday::Response::Logger)     # log request & response to STDOUT
          c.use (Faraday::Adapter::NetHttp)
          c.response :xml,  :content_type => /\bxml$/
        end
      end

      def request(method, path, params={}, raw=false)
        headers = {'Accept' => 'application/xml'}
        path = "#{path}"

        response = connection.send(method, path, params) do |request|
          request.url(path, params)
        end

        if [404, 403, 400].include?(response.status)
          raise HealthCare::Error, response.body["error"]
        end

        raw ? response : response.body
      end

      def get(path, params={})
        request(:get, path, params)
      end
    end

    class Client
      include Request

      def publicOptions(options={})
        post("/publicoptions",options)
      end

      def countries
        get("/countries")
      end

      def cities(country=nil)
        get("/cities")
      end

      def restaurants(options={})
        get("/restaurants", options)
      end

      def restaurant(id)
        get("/restaurants/#{id}")
      end
    end

  end
end
