# JSON Parsing example
require "rubygems"
require "json"

# Read JSON from a file, iterate over objects
file = open("ec2s.json")
json = file.read

parsed = JSON.parse(json)

jsonObject = parsed
#parsed.each do |jsonObject|
  hashes = jsonObject["Instances"].map do |instance|
    h = {}.tap do |hash|
      hash[:private_ip_address] = instance["PrivateIpAddress"]
      hash[:instance_id] = instance["InstanceId"]
      hash[:state] = instance["State"]["Name"]
      hash[:name] = instance["Tags"].find { |tag| tag["Value"] if tag["Key"] == "Name" }
    end
#    p h
    h
  end
  p hashes
  hashes
#end


