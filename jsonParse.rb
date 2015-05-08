# JSON Parsing example
require "rubygems"
require "json"

string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
parsed = JSON.parse(string) # returns a hash

p parsed["desc"]["someKey"]
p parsed["main_item"]["stats"]["a"]

# Read JSON from a file, iterate over objects
file = open("ec2s.json")
json = file.read

parsed = JSON.parse(json)

#p parsed.keys

parsed["Instances"].each do |inst|
  ip=nil
  tags=Hash.new
  is_running=false
#  p inst
     
  inst.each do |prop|
#    p prop

    case prop[0]
      when "PrivateIpAddress"
        p prop[1]
        ip = prop[1]
      when "State"
        is_running = prop[1]["Name"]=="running"
      when "Tags"
        prop[1].each do |tag|
          p tag["Value"] if tag["Key"] == "Name"
          tags[tag["Key"]]=tag["Value"]
       end
    end

#    if prop[0] == "PrivateIpAddress"
#      p prop[1]
#    elsif prop[0] == ["State"]
#      p prop[1]
#    elsif prop[0]["State"]["Name"] == "running"
#      p 'running!'
#    end
  end
  p 'Machine '+ ip+ ' is running' if is_running
  p tags
  ret1 = [tags["Name"], ip] if is_running and tags["cost.centre"] == "1234"
  p ret1
  ret2 = {:name => tags["Name"], :ip => ip, :cost_centre=> tags["cost.centre"]}
  p ret2
end



