END_POINT = "https://api.name.com"
ACTIONS = {
  :hello => "/api/hello",
  :login => "/api/login",
  :check_domain => "/api/domain/check"
}
require 'faraday'
require 'yajl'
require 'faraday_middleware'
require 'multi_json'
require 'hashie'
require 'cgi'

module NameDotCom
  class API
    def initialize(*args)


      @api = Faraday.new(:url => END_POINT) do |builder|
                        builder.request  :url_encoded
                        builder.use Faraday::Response::Mashify
                        builder.use Faraday::Response::ParseJson
                        builder.request  :json 
                       builder.adapter  :net_http
      end


      if args[0].is_a? String and args[1].is_a? String then
        login(args[0],args[1])
      end

    end
    def login(account,api_token)
      @api.get(ACTIONS[:login],{:account => account, :api_token =>api_token}).body
    end
    def hello
     @api.get(ACTIONS[:hello]).body
    end
    def check_domain(params)
      @api.post('/api/domain/check',params,'Content-Type' => 'application/json').body
    end

  end 
end


