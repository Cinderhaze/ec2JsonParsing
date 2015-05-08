# JSON Parsing example
require "rubygems"
require "json"

# Read JSON from a file, iterate over objects
file = open("ec2s.json")
json = file.read

parsed = JSON.parse(json)

parsed["Instances"].each do |inst|
  ip=nil
  tags=Hash.new
  is_running=false
     
  inst.each do |key, value|
#    p prop

    case key
      when "PrivateIpAddress"
#        p prop[1]
        ip = value
      when "State"
        is_running = value["Name"]=="running"
      when "Tags"
        value.each do |tag|
#          p tag["Value"] if tag["Key"] == "Name"
          tags[tag["Key"]]=tag["Value"]
       end
    end
  end

#  p 'Machine '+ ip+ ' is running' if is_running
#  p tags
  ret1 = [tags["Name"], ip] if is_running and tags["cost.centre"] == "1234"
  p ret1
  ret2 = {:name => tags["Name"], :ip => ip, :cost_centre=> tags["cost.centre"]}
  p ret2
end



