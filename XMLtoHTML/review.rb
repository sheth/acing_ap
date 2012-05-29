#Ruby program to read new review.xml and output the problem pages (a html document) to the console.

file = File.new("../kb/review.xml", "r")
problem_main = false
problem_other = false
other_same = false
other_done = false
unit_title = nil
next_problem_id = nil

while (line = file.gets)
  line.chomp!.strip! #remove leading and trailing spaces and new lines.

  if problem_main
    if line.start_with? "<id>"
      other_done = false
      other_same = false
      fileOther = File.new("../kb/review.xml", "r")

      while (other_done == false and otherLine = fileOther.gets)
        otherLine.chomp!.strip!
        if otherLine == line
          other_same = true
          next
        elsif other_same
          if otherLine.start_with? "</unit>"
            next_problem_id = "done"
            other_done = true
          elsif otherLine.start_with? "<id>"
            next_problem_id = otherLine[4..-6]
            other_done = true
          end
          next
        end
      end

      fileOther.close

      puts     "<div data-role=\"page\" id=\"#{line[4..-6]}\" data-theme=\"c\">"
      puts     "   <div data-role=\"header\" data-theme=\"c\" data-position=\"fixed\">"
      puts     "      <a href=\"review.html\" data-icon=\"home\" data-transition=\"pop\">Review it!</a>"
      puts     "      <h1>#{unit_title}</h1>"
      puts     "      <div data-role=\"navbar\">"
      puts     "         <ul>"
      puts     "            <li><a href=\"#\" data-rel=\"back\">Back</a></li>"
      puts     "            <li><a href=\"##{next_problem_id}\">Next</a></li>"
      puts     "         </ul>"
      puts     "      </div>"
      puts     "   </div>"
      puts     "   <div data-role=\"content\" data-theme=\"c\">"

      next

    elsif line.start_with? "<question>"
      puts     "      <h3>#{line[10..-12]}</h3>"


    elsif line.start_with? "<rightAnswer>"
      puts     "	  <a href=\"#correct\" onclick=\"correctAnswer('#{next_problem_id}')\" data-role=\"button\" data-inline=\"true\" data-rel=\"dialog\" data-icon=\"star\" data-iconpos=\"notext\">X</a>#{line[13..-15]}<br />"

    elsif line.start_with? "<wrongAnswer>"
      puts     "	  <a href=\"#incorrect\" data-role=\"button\" data-inline=\"true\" data-rel=\"dialog\" data-icon=\"star\" data-iconpos=\"notext\">X</a>#{line[13..-15]}<br />"

    elsif line.start_with? "</problem>"
      problem_main = false
      puts     "   </div>"
      puts     "</div>"

    end
    next

  elsif line.start_with? "<title>"
    unit_title = line[7..-9]
    next


  elsif line.start_with? "<problem>"
    problem_main = true
    next

  end
end

file.close