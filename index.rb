load 'den.parser.rb'
require 'pp'

file = File.new("den.code.txt", "r")
content = Array.new
while (line = file.gets)
    content.push(line)
end
file.close

puts "<pre>"
puts denParse(content)
puts "----------------------------------------------------------------------\n"
pp @memory
puts "</pre>"