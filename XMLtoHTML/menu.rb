#Ruby program to read new learnIt.txt and output the menu (a html document) to the console.
#units.rb output is learnIt.txt which is xml file
filename = "../../output/units.xml"
file = File.new(filename, "r")
section_started = false
unit_title = nil
unit_id = nil

puts     "<div data-role=\"page\" id=\"menu\" data-theme=\"c\">"
puts     "   <div data-role=\"header\" data-theme=\"c\">"
puts     "      <h1>Learn it!</h1>"
puts     "   </div>"
puts     "   <div data-role=\"content\" data-theme=\"c\">"
puts     "      <ul data-role=\"listview\" data-theme=\"c\">"

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if line.start_with? "<section>"
    section_started = true
    next

  elsif line.start_with? "</section>"
    section_started = false
    next

  elsif section_started == false
    if line.start_with? "<id>"
      unit_id = line[4..-6]
      puts     "         <li><a href=\"##{unit_id}\" data-rel=\"dialog\">"
    elsif line.start_with? "<title>"
      unit_title = line[7..-9]
      puts     "            <h3>#{unit_title}</h3>"
      puts     "         </a></li>"
    end
    next

  end
end

puts     "         <li data-theme=\"a\"><a href=\"#models\">"
puts     "            <h3>Models</h3>"
puts     "         </a></li>"
puts     "         <li data-theme=\"a\"><a href=\"#glossary\">"
puts     "            <h3>Glossary</h3>"
puts     "         </a></li>"
puts     "      </ul>"
puts     "   </div>"
puts     "   <div data-role=\"footer\" data-theme=\"c\">"
puts     "      <h4>Acing AP</h4>"
puts     "   </div>"
puts     "</div>"

file.close

fileN = File.new(filename, "r")
section_started = false
section_id = nil

while (lineN = fileN.gets)
  lineN.chomp!.strip! #remove leading and trailing spaces and new lines.

  if lineN.start_with? "<section>"
    section_started = true
    next

  elsif lineN.start_with? "</section>"
    section_started = false
    next

  elsif section_started == false
    if lineN.start_with? "<id>"
      unit_id = lineN[4..-6]
      puts     "<div data-role=\"page\" id=\"#{unit_id}\">"
      puts     "   <div data-role=\"content\" data-theme=\"a\">"
    elsif lineN.start_with? "<title>"
      unit_title = lineN[7..-9]
      puts     "            <h3>#{unit_title}</h3>"
    elsif lineN.start_with? "<unit>"
      puts     "      <a href=\"#\" data-role=\"button\" data-rel=\"back\" data-theme=\"a\">Back</a>"
      puts     "   </div>"
      puts     "</div>"
    end

  elsif section_started
    if lineN.start_with? "<id>"
      section_id = lineN[4..-6]
    elsif lineN.start_with? "<title>"
      puts     "      <a href=\"##{section_id}\" data-role=\"button\" data-transition=\"pop\" data-theme=\"c\">#{lineN[7..-9]}</a>"
    end

  end
end

puts     "      <a href=\"#\" data-role=\"button\" data-rel=\"back\" data-theme=\"a\">Back</a>"
puts     "   </div>"
puts     "</div>"

fileN.close