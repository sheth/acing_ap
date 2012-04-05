#Ruby program to read models.txt and output a xml document to the console.
if ARGV[0] == "print_dtd"
  puts       '<?xml version="1.0"?>'
  puts       '<!DOCTYPE models ['
  puts       '        <!ELEMENT models (model)+>'
  puts       '        <!ELEMENT model (id, title, image?, description)>'
  puts       '        <!ELEMENT id (#PCDATA)>'
  puts       '        <!ELEMENT title (#PCDATA)>'
  puts       '        <!ELEMENT image (#PCDATA)>'
  puts       '        <!ELEMENT description (#PCDATA)>'
  puts       ']>'
end
puts       "<models>"
file = File.new("models.txt", "r")
model_started = false
id_counter = 1
while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.
  if !model_started && !line.empty?
    model_started = true
    puts   ' <model>'
    puts   "    <id>Model"  + id_counter.to_s + "</id>"
    puts   "    <title>" + line + "</title>"
    id_counter += 1
    next
  elsif model_started && line.empty?
    model_started = false
    puts   ' </model>'
    next
  elsif model_started && line.index('img')
    puts   "    <image>" + line.gsub('img ', '') + "</image>" #remove 'img '
    next
  elsif model_started && !line.empty?
    puts   "    <description>#{line}</description>"
    next
  else
    next
  end
end
file.close
if model_started
  puts     '  </model>'
end
puts       '</models>'