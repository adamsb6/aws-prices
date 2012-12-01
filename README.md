# aws-prices

Retrieves pricing information from AWS JSON documents.

## Usage

```
require 'aws-prices'

prices = AWSPrices.new

m1_large_price = prices.get_price('us-east-1','m1.large','linux')
```