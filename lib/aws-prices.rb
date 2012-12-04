require 'json'
require 'net/http'


class AWSPrices
    PRICING_DOCUMENT = 'http://aws.amazon.com/ec2/pricing/pricing-on-demand-instances.json'
    def initialize
        @type_translation = {
            'm1.small' => ['stdODI', 'sm'],
            'm1.medium' => ['stdODI', 'med'],
            'm1.large' => ['stdODI', 'lg'],
            'm1.xlarge' => ['stdODI', 'xl'],
            't1.micro' => ['uODI', 'u'],
            'm2.xlarge' => ['hiMemODI', 'xl'],
            'm2.2xlarge' => ['hiMemODI', 'xxl'],
            'm2.4xlarge' => ['hiMemODI', 'xxxxl'],
            'c1.medium' => ['hiCPUODI', 'med'],
            'c1.xlarge' => ['hiCPUODI', 'xl'],
            'cc1.4xlarge' => ['clusterComputeI', 'xxxxl'],
            'cc2.8xlarge' => ['clusterComputeI', 'xxxxxxxxl'],
            'cg1.4xlarge' => ['clusterGPUI', 'xxxxl'],
            'hi1.4xlarge' => ['hiIoODI', 'xxxx1']
        }

        @region_translation = {
            'us-east-1' => 'us-east',
            'us-west-2' => 'us-west-2',
            'us-west-1' => 'us-west',
            'eu-west-1' => 'eu-ireland',
            'ap-southeast-1' => 'apac-sin',
            'ap-northeast-1' => 'apac-tokyo',
            'sa-east-1' => 'sa-east-1'
        }
        
        update_prices
    end

    def update_prices
        uri = URI(PRICING_DOCUMENT)
        http = Net::HTTP.new uri.host, uri.port
        http.open_timeout = 60
        http.read_timeout = 60

        response = http.get uri.path
        
        pricing_document = ::JSON.load response.body
        
        currency = pricing_document['config']['currencies'].first
        
        # build better hash so that we dont have to scan on each call
        @pricing_hash = {}
        pricing_document['config']['regions'].each do |r|
            @pricing_hash[r['region']] = {}
            
            r['instanceTypes'].each do |t|
                @pricing_hash[r['region']][t['type']] = {}
                t['sizes'].each do |s|
                    @pricing_hash[r['region']][t['type']][s['size']] = {}
                    s['valueColumns'].each do |vc|
                        @pricing_hash[r['region']][t['type']][s['size']][vc['name']] = vc['prices'][currency].to_f
                    end
                end
            end
        end
        
    end
        
    def get_price(region, instance_type, os)
        r = @region_translation[region]
        t = @type_translation[instance_type]

        price = @pricing_hash[r][t[0]][t[1]][os]
        return price
    end

end