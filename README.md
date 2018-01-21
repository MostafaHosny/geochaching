# README

Geocachnig Rails 
------------------------------------
For testing run 'rspec'

API's 

1- create new location with secret message 

Post: localhost:3000/api/v1/locations

body: 
	{
		"location":{
		"message_attributes": {"content":"seveeneeeeeeeeeeeasesead"} ,
		"lat" : "31.180696122" ,
		"lng" : "36.169139291"
 		}
	}

----------------------------------------------------------------------------------

2-Query for all messages within a 100km radius around a certain position 

Get: localhost:3000/api/v1/locations/nearby

params: lat=36.1806961223 & lng=36.169139292



-----------------------------------------------------------------------------------
3-Query for the closest message to a certain position

Get: localhost:3000/api/v1/locations/closest

params: lat=36.1806961223 & lng=36.169139292