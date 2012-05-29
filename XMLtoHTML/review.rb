#Ruby program to read new revietIt.txt and output the problem pages (a html document) to the console.

file = File.new("reviewIt.txt", "r")
problemMain = false
problemOther = false
otherSame = false
otherDone = false
unitTitle = nil
nextProblemID = nil

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if problemMain
    if line.start_with? "<id>"
      otherDone = false
      otherSame = false
      fileOther = File.new("reviewIt.txt", "r")

      while (otherDone == false and otherLine = fileOther.gets)
        otherLine.chomp!.strip!
        if otherLine == line
          otherSame = true
          next
        elsif otherSame
          if otherLine.start_with? "</unit>"
            nextProblemID = "done"
            otherDone = true
          elsif otherLine.start_with? "<id>"
            nextProblemID = otherLine[4..-6]
            otherDone = true
          end
          next
        end
      end

      fileOther.close

      puts     "<div data-role=\"page\" id=\"#{line[4..-6]}\" data-theme=\"c\">"
      puts     "   <div data-role=\"header\" data-theme=\"c\" data-position=\"fixed\">"
      puts     "      <a href=\"review.html\" data-icon=\"home\" data-transition=\"pop\">Review it!</a>"
      puts     "      <h1>#{unitTitle}</h1>"
      puts     "      <div data-role=\"navbar\">"
      puts     "         <ul>"
      puts     "            <li><a href=\"#\" data-rel=\"back\">Back</a></li>"
      puts     "            <li><a href=\"##{nextProblemID}\">Next</a></li>"
      puts     "         </ul>"
      puts     "      </div>"
      puts     "   </div>"
      puts     "   <div data-role=\"content\" data-theme=\"c\">"

      next

    elsif line.start_with? "<question>"
      puts     "      <h3>#{line[10..-12]}</h3>"


    elsif line.start_with? "<rightAnswer>"
      puts     "	  <a href=\"#correct\" onclick=\"correctAnswer('#{nextProblemID}')\" data-role=\"button\" data-inline=\"true\" data-rel=\"dialog\" data-icon=\"star\" data-iconpos=\"notext\">X</a>#{line[13..-15]}<br />"

    elsif line.start_with? "<wrongAnswer>"
      puts     "	  <a href=\"#incorrect\" data-role=\"button\" data-inline=\"true\" data-rel=\"dialog\" data-icon=\"star\" data-iconpos=\"notext\">X</a>#{line[13..-15]}<br />"

    elsif line.start_with? "</problem>"
      problemMain = false
      puts     "   </div>"
      puts     "</div>"

    end
    next

  elsif line.start_with? "<title>"
    unitTitle = line[7..-9]
    next


  elsif line.start_with? "<problem>"
    problemMain = true
    next

  end
end

file.close