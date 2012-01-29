#Ruby program to read a file and print the contents with line nos.
puts         "<units>"
file = File.new("units.txt", "r")
line_empty = false
unit = nil
section_started = false
while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.
  if line.start_with? "Unit"
    unit = line.split('-')
    puts     "  <id>" + unit[0].sub(/ /, '-') + "</id>"
    puts     "  <title>#{unit[1].chomp.strip}</title>"
    line_empty = false
    next
  elsif line.chomp.empty?
    line_empty = true  
    if section_started
      puts   '  </section>'
      section_started = false
    end  
    next
  elsif line_empty
    puts     "  <section>"
    puts     "    <id>" + unit[1].chomp.strip.sub(/ /, '-') + "-" + line.sub(/ /, '-') + "</id>"
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