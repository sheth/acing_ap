#Ruby program to read new learnIt.txt and output the section pages (a html document) to the console.

file = File.new("learnIt.txt", "r")
sectionMain = false
sectionOther = false
otherSame = false
otherDone = false
unitTitle = nil
nextSectionID = nil

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if sectionMain
    if line.start_with? "<id>"
      otherDone = false
      otherSame = false
      fileOther = File.new("learnIt.txt", "r")

      while (otherDone == false and otherLine = fileOther.gets)
        otherLine.chomp!.strip!
        if otherLine == line
          otherSame = true
          next
        elsif otherSame
          if otherLine.start_with? "</unit>"
            nextSectionID = "done"
            otherDone = true
          elsif otherLine.start_with? "<id>"
            nextSectionID = otherLine[4..-6]
            otherDone = true
          end
          next
        end
      end

      fileOther.close

      puts     "<div data-role=\"page\" id=\"#{line[4..-6]}\" data-theme=\"c\">"
      puts     "   <div data-role=\"header\" data-theme=\"c\" data-position=\"fixed\">"
      puts     "      <a href=\"index.html\" data-icon=\"home\" data-transition=\"pop\">Learn it!</a>"
      puts     "      <h1>#{unitTitle}</h1>"
      puts     "      <div data-role=\"navbar\">"
      puts     "         <ul>"
      puts     "            <li><a href=\"#\" data-rel=\"back\">Back</a></li>"
      puts     "            <li><a href=\"##{nextSectionID}\">Next</a></li>"
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
      sectionMain = false
      puts     "   </div>"
      puts     "</div>"

    end
    next

  elsif line.start_with? "<title>"
    unitTitle = line[7..-9]
    next


  elsif line.start_with? "<section>"
    sectionMain = true
    next

  end
end

file.close