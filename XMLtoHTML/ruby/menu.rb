#Ruby program to read new units.txt and output the menu (a html document) to the console.

file = File.new("units.txt", "r")
sectionStarted = false
unitTitle = nil
unitID = nil

puts     "<div data-role=\"page\" id=\"menu\" data-theme=\"c\">"
puts     "   <div data-role=\"header\" data-theme=\"c\">"
puts     "      <h1>Learn it!</h1>"
puts     "   </div>"
puts     "   <div data-role=\"content\" data-theme=\"c\">"
puts     "      <ul data-role=\"listview\" data-theme=\"c\">"

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if line.start_with? "<section>"
    sectionStarted = true
    next

  elsif line.start_with? "</section>"
    sectionStarted = false
    next

  elsif sectionStarted == false
    if line.start_with? "<id>"
      unitID = line[4..-6]
      puts     "         <li><a href=\"##{unitID}\" data-rel=\"dialog\">"
    elsif line.start_with? "<title>"
      unitTitle = line[7..-9]
      puts     "            <h3>#{unitTitle}</h3>"
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



fileN = File.new("units.txt", "r")
sectionStarted = false
sectionID = nil

while (lineN = fileN.gets)
  lineN.chomp!.strip! #remove leading and trailing spaces and new lines.

  if lineN.start_with? "<section>"
    sectionStarted = true
    next

  elsif lineN.start_with? "</section>"
    sectionStarted = false
    next

  elsif sectionStarted == false
    if lineN.start_with? "<id>"
      unitID = lineN[4..-6]
      puts     "<div data-role=\"page\" id=\"#{unitID}\">"
      puts     "   <div data-role=\"content\" data-theme=\"a\">"
    elsif lineN.start_with? "<title>"
      unitTitle = lineN[7..-9]
      puts     "            <h3>#{unitTitle}</h3>"
    elsif lineN.start_with? "</units>"
      puts     "      <a href=\"#\" data-role=\"button\" data-rel=\"back\" data-theme=\"a\">Back</a>"
      puts     "   </div>"
      puts     "</div>"
    end

  elsif sectionStarted
    if lineN.start_with? "<id>"
      sectionID = lineN[4..-6]
    elsif lineN.start_with? "<title>"
      puts     "      <a href=\"##{sectionID}\" data-role=\"button\" data-transition=\"pop\" data-theme=\"c\">#{lineN[7..-9]}</a>"
    end

  end
end
