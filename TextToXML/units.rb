#Ruby program to read units.txt and output a xml document to the console.
puts         '<?xml version="1.0"?>'
puts         "<!DOCTYPE units ["
puts         "        <!ELEMENT units (id, title, section+)+>"
puts         "        <!ELEMENT section (id, title, description+)>"
puts         "        <!ELEMENT id (#PCDATA)>"
puts         "        <!ELEMENT title (#PCDATA)>"
puts         "        <!ELEMENT description (#PCDATA)>"
puts         "]>"
puts         "<units>"
file = File.new("units.txt", "r")
line_empty = false
unit = nil
section_started = false
while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.
  if line.start_with? "Unit"
    puts         '</units>'
    puts         "<units>"
    unit = line.split('-')
    puts     "  <id>" + unit[0].gsub(/ /, '-') + "</id>"
    puts     "  <title>#{unit[1].chomp.strip}</title>"
    line_empty = false
    next
  elsif line.empty?
    line_empty = true  
    if section_started
      puts   '  </section>'
      section_started = false
    end  
    next
  elsif line_empty
    puts     "  <section>"
    puts     "    <id>" + unit[1].chomp.strip.gsub(/ /, '-') + "-" + line.gsub(/ /, '-') + "</id>"
    puts     "    <title>#{line}</title>"
    line_empty = false
    section_started = true
    next
  else 
    puts     "    <description>#{line}</description>"
    next
  end
end
file.close
if section_started
  puts       '  </section>'
  section_started = false
end  
puts         '</units>'