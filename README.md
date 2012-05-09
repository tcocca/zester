# Zester

Zester is an API wrapper written in Ruby designed to be used with multiple api keys for a system that has multiple users each with their own key.

Zillow API documentation can be found here: http://www.zillow.com/howto/api/APIOverview.htm

You must have a Zillow API Key (ZWSID) which you can obtain here:  https://www.zillow.com/webservice/Registration.htm

## Usage

Every api call can be made off of a Zester::Client so the first step is to instantiate a client:

```ruby
zester = Zester::Client.new('your_api_key')
```

You do not need to pass the 'zws-id' param to any api calls, this param will be added automatically by the client and the api key that was passed in.

All other params for each api call are passed as a hash with the keys as strings in the exact same format as specified in the Zillow API docs

### Home Valuation

Zillow 'Home Valuation' calls are accessed off of the client#valuation method:

```ruby
zester.valuation.zestimate('zpid' => 12345)
zester.valuation.search_results('address' => '123 Main Street', 'citystatezip' => 'Boston, MA')
zester.valuation.chart('zpid' => 12345)
zester.valuation.comps('zpid' => 12345)
```

The #chart call defaults to the 'unit-type' param to 'dollar', this can be overridden in the params hash.
The #comps call defaults to the 'count' param to 10, this can be overridden in the params hash.

### Property Details

Zillow 'Property Details' api calls are accessed off the client#property method:

```ruby
zester.property.deep_comps('zpid' => 12345)
zester.property.deep_search_results('address' => '123 Main Street', 'citystatezip' => 'Boston, MA')
zester.property.updated_property_details('zpid' => 12345)
```

The #deep_comps call defaults to the 'count' param to 10, this can be overridden in the params hash.

### Neighborhood Data

Zillow 'Neighborhood Data' api calls are accessed off the client#neighborhood method:

```ruby
zester.neighborhood.demographics('state' => 'MA', 'city' => 'Boston')
zester.neighborhood.region_children('regionID' => 123, 'state' => 'MA')
zester.neighborhood.region_chart('state' => 'MA')
```

The #region_chart call defaults to the 'unit-type' param to 'dollar', this can be overridden in the params hash.

### Mortgage Rates

Zillow 'Mortgage Rates' api calls are accessed off the client#mortgage method:

```ruby
zester.mortgage.rate_summary('MA')
```

The #rate_summary method does not take a params hash, instead it only takes an optional state param as a string.  This is the only param that applies.

#### Responses

Each API call method returns a Zester::Response instance.  Zester::Response converts the XML response into a Hashie::Rash (http://github.com/tcocca/rash) object which basically takes the hash returned by MultiXml and converts that into an object so that you can use dot notation to access the keys/values as methods.  Rash converts the keys from camelCase into underscore_case to make it more ruby-esque.

Zester::Response also provides a nice method missing to make getting at the values from the xml easier.  The method missing works off of the <response> node of the xml.  So in the following example:

```xml
<?xml version="1.0" encoding="utf-8" ?> 
<Chart:chart xmlns:Chart="http://www.zillow.com/vstatic/3/static/xsd/Chart.xsd">
  <request>
    <zpid>48749425</zpid> 
    <unit-type>percent</unit-type> 
    <width>300</width> 
    <height>150</height> 
  </request>
  <message>
    <text>Request successfully processed</text> 
    <code>0</code> 
  </message>
  <response>
    <url>http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425</url> 
  </response>
</Chart:chart>
<!-- H:11  T:1ms  S:311 --> 
``` 

Which is response from a call to zester.valuation.chart (http://www.zillow.com/howto/api/GetChart.htm) you have the following:

```ruby
response = zester.valuation.chart('zpid' => '48749425')
response.success? #=> true
response.response_code #=> 0
response.url #=> http://www.zillow.com/app?chartDuration=1year&chartType=partner&height=150&page=webservice%2FGetChart&service=chart&showPercent=true&width=300&zpid=48749425
```

So, anything inside the <response> node can be accessed directly by the method missing.

You can still get at anything in the xml by accessing the key off of the body:

```ruby
response.body.message
response.body.message.text
response.body.request
response.body.response
response.body.response.url
```

Zester::Response also provides a fea extra helper methods:

```ruby
response.response_code #=> returns response.body.message.code.to_i
response.success? #=> returns true if response_code == 0
response.error_message #=> returns response.body.message.text
response.near_limit? #=> returns true of response.body.message.limit_warning == 'true'
```

## TODO

* Support the Mortgage Calculator api calls
* Create YARD documentation

## Contributing to Zester
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Tom Cocca (http://github.com/tcocca). See LICENSE for further details.