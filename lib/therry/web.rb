require 'sinatra'
require 'rest-client'
require 'json'

require 'therry/metrics'

module Therry
  class Web < Sinatra::Base

    before do
#      if request.accept.include?("application/json")
#        content_type "application/json"
#        status 200
#      else
#        halt
#      end
    end

    get '/' do
      Metric.all.to_json
    end

    get '/search/?' do
      Metric.find(params[:pattern]).to_json
    end

    get '/health/?' do
      {:status => 'OK', :count => Metric.all.count}.to_json
    end
  end
end
