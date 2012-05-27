#Ruby program to read units.txt and output a xml document to the console.
if ARGV[0] == "print_dtd"
  puts         '<?xml version="1.0"?>'
  puts         "<!DOCTYPE units ["
  puts         "        <!ELEMENT units (unit)+>"
  puts         "        <!ELEMENT unit (id, title, section+)+>"
  puts         "        <!ELEMENT section (id, title, image?, description+)>"
  puts         "        <!ELEMENT id (#PCDATA)>"
  puts         "        <!ELEMENT title (#PCDATA)>"
  puts         "        <!ELEMENT description (#PCDATA)>"
  puts         "]>"
end
file = File.new("units.txt", "r")
puts         '<units>'
empty_line = false
unit = nil
section_started = false
unit_started = false
while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.
  if line.start_with? "Unit"
    if unit_started
      puts   '  </unit>'
    end
    unit_started = true
    puts     "  <unit>"
    unit = line.split('-')
    puts     "    <id>" + unit[0].gsub(/ /, '-') + "</id>"
    puts     "    <title>#{unit[1].chomp.strip}</title>"
    empty_line = false
    next
  elsif line.empty?
    empty_line = true  
    if section_started
      puts   '    </section>'
      section_started = false
    end  
    next
  elsif empty_line
    puts     "    <section>"
    puts     "      <id>" + unit[1].chomp.strip.gsub(/ /, '-') + "-" + line.gsub(/ /, '-') + "</id>"
    puts     "      <title>#{line}</title>"
    empty_line = false
    section_started = true
    next
  else 
    puts     "      <description>#{line}</description>"
    next
  end
end
file.close
if section_started
  puts       '    </section>'
end
if unit_started
  puts       '  </unit>'
end
puts         '</units>'
