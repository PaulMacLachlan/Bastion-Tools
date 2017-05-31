puts "Enter Public String please:"
strPublic = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Private String please:"
strPrivate = gets.gsub(/\s+/, "") # converts input into string and removes whitespace
puts "Enter Secret String please:"
strSecret = gets.gsub(/\s+/, "") # converts input into string and removes whitespace

clean_output = Hash.new # hash for outputting keys with values on same line

clean_output["Public"] = strPublic
clean_output["Private"] = strPrivate
clean_output["Secret"] = strSecret

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

def pbpaste
  `pbpaste`
end

final_string = "Public ID: #{strPublic}" + "\n" + "Private ID: #{strPrivate}" "\n" + "Secret ID: #{strSecret}" + "\n"
puts final_string
pbcopy final_string