#Ruby program to read new learnIt.txt and output the section pages (a html document) to the console.
filename = "../../output/units.xml"
file = File.new(filename, "r")
section_main = false
section_other = false
other_same = false
other_done = false
unit_title = nil
next_section_id = nil

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if section_main
    if line.start_with? "<id>"
      other_done = false
      other_same = false
      fileOther = File.new(filename, "r")

      while (other_done == false and otherLine = fileOther.gets)
        otherLine.chomp!.strip!
        if otherLine == line
          other_same = true
          next
        elsif other_same
          if otherLine.start_with? "</unit>"
            next_section_id = "done"
            other_done = true
          elsif otherLine.start_with? "<id>"
            next_section_id = otherLine[4..-6]
            other_done = true
          end
          next
        end
      end

      fileOther.close

      puts     "<div data-role=\"page\" id=\"#{line[4..-6]}\" data-theme=\"c\">"
      puts     "   <div data-role=\"header\" data-theme=\"c\" data-position=\"fixed\">"
      puts     "      <a href=\"index.html\" data-icon=\"home\" data-transition=\"pop\">Learn it!</a>"
      puts     "      <h1>#{unit_title}</h1>"
      puts     "      <div data-role=\"navbar\">"
      puts     "         <ul>"
      puts     "            <li><a href=\"#\" data-rel=\"back\">Back</a></li>"
      puts     "            <li><a href=\"##{next_section_id}\">Next</a></li>"
      puts     "         </ul>"
      puts     "      </div>"
      puts     "   </div>"
      puts     "   <div data-role=\"content\" data-theme=\"c\">"

      next

    elsif line.start_with? "<title>"
      puts     "      <h1>#{line[7..-9]}</h1>"


    elsif line.start_with? "<description>"
      puts     "      <p style=\"margin-left: 10px; margin-right: 10px;\">#{line[13..-15]}</p>"


    elsif line.start_with? "</section>"
      section_main = false
      puts     "   </div>"
      puts     "</div>"

    end
    next

  elsif line.start_with? "<title>"
    unit_title = line[7..-9]
    next


  elsif line.start_with? "<section>"
    section_main = true
    next

  end
end

file.close