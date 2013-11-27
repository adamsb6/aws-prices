require 'json'
require 'net/http'

class AWSPrices
    def awsnow_price(region, instance_type, os)
      uri = URI("http://api.awsnow.info/ec2/#{os}/?region=#{region}&instance=#{instance_type}&tenancy=default&option=demand")
      http = Net::HTTP.new uri.host, uri.port
      http.open_timeout = 60
      http.read_timeout = 60
      response = http.get uri.request_uri
      
      doc = ::JSON.load response.body
      
      return doc['results'].first['price']
    end
    
    def get_price(region, instance_type, os)
        price = awsnow_price(region, instance_type, os)

        return price
    end

end