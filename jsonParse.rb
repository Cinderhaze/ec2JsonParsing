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
  state=nil
     
  inst.each do |key, value|

    case key
      when "PrivateIpAddress"
        ip = value
      when "State"
        is_running = value["Name"]=="running"
        state = value["Name"]
      when "Tags"
        value.each do |tag|
          tags[tag["Key"]]=tag["Value"]
       end
    end
  end

  ret1 = [tags["Name"], ip, state, tags["Env"]] 
  p ret1
  ret2 = {:name => tags["Name"], :ip => ip, :state => state, :env=>tags["Env"]}
  p ret2
end



