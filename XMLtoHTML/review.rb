require "rexml/document"
require "./AcingAP"

#<!ELEMENT units (unit+)>
#<!ELEMENT unit (id, title, problem+)+>
#<!ELEMENT problem (id, question, wrongAnswer*, rightAnswer, wrongAnswer*)>
filename = "../kb/review.xml"
file = File.new(filename)
doc = REXML::Document.new file
AcingAP.open_head
puts %{
	<script type="text/javascript">
			function correctAnswer(nextID)
			{
			 	document.getElementById("correctNext").href="#" + nextID;
			}
	</script>
        <style>
          .ui-btn-inner { white-space: normal !important; }
  </style>
</head>
<body>
<div id="full">
<div data-role="page" id="menu" data-theme="c">
   <div data-role="header" data-theme="c">
      <h1>Review it!</h1>
   </div>
   <div data-role="content" data-theme="c">
      <!--Menu Start-->
      <ul data-role="listview" data-theme="c">
     }
#we will have to traverse twice, first to provide the links and second will have the actual questions
doc.elements.each("units/unit") do |unit_element|
  id = unit_element.elements['problem/id'].text
  title = unit_element.elements['title'].text
  puts %{ <li><a href="##{id}"><h3>#{title}</h3></a></li> }
end
puts %{
      </ul>
      <!--Menu End-->
}
AcingAP.footer(true)

#get the array this time, as we need to create link to the next model
problem_array = doc.elements.to_a("units/unit/problem")
for i in 0...problem_array.size do
  id = problem_array[i].elements['id'].text
  title = problem_array[i].elements['../title'].text
  puts %{
    <div data-role="page" id="#{id}" data-theme="c">
      <div data-role="header" data-theme="c" data-position="fixed">
        <a href="review.html" data-icon="home" data-transition="pop">Review it!</a>
        <h1>#{title}</h1>
        <div data-role="navbar">
          <ul>
            <li><a href="#" data-rel="back">Back</a></li>
       }
  next_title_id = nil
  if (i < (problem_array.size - 1))
    next_title_id = problem_array[i+1].elements['id'].text
    puts %{
      <li><a href="##{next_title_id}">Next</a></li>
    }
  end
  question = problem_array[i].elements['question'].text
  puts %{
        </ul>
        </div>
      </div>
      <div data-role="content" data-theme="c">
        <h3>#{question}</h3>
        <ol style="list-style-type:upper-alpha">
  }
  problem_array[i].each_element_with_text do |e|
    if (e.name.eql?("rightAnswer") && next_title_id)
      puts %{
        <li><a href="#correct" onclick="correctAnswer('#{next_title_id}')" data-inline="true" data-rel="dialog" data-role="button" data-mini="true">#{e.text}</a></li>
      }
    elsif (e.name.eql?("rightAnswer") && !next_title_id)
      puts %{
	      <li><a href="#correct" onclick="correctAnswer('done')" data-inline="true" data-rel="dialog" data-role="button" data-mini="true">#{e.text}</a></li>
      }
    elsif (e.name.eql?("wrongAnswer"))
      puts %{
	      <li><a href="#incorrect" data-inline="true" data-rel="dialog" data-role="button" data-mini="true">#{e.text}</a></li>
      }
    end
  end
  puts %{
        </ol>
  }
  AcingAP.footer(true)
end
puts %{
<!-- Correct Page-->
<div data-role="page" id="correct">
  <div data-role="header" data-theme="d">
    <h1>Correct</h1>
  </div>
  <div data-role="content" data-theme="c">
    <img style="display:block; margin-left:auto; margin-right:auto;" src="images/right.png" />
    <p style="text-align: center; color:green;"><b>Way to ace it!</b></p>
    <a id="correctNext" data-role="button" href="#" data-icon="check" data-transition="pop">Next</a>
    <a href="review.html" data-icon="home" data-transition="pop" data-role="button">Review it!</a>
  </div>
</div>
<!-- Correct Page-->

<!-- Incorrect Page-->
<div data-role="page" id="incorrect">
  <div data-role="header" data-theme="d">
    <h1>Incorrect</h1>
  </div>
  <div data-role="content" data-theme="c">
    <img style="display:block; margin-left:auto; margin-right:auto;" src="images/wrong.png" />
    <p style="text-align: center; color:red;"><b>Try again!</b></p>
    <a href="#" data-rel="back" data-icon="back" data-role="button">Back</a>
    <a href="review.html" data-icon="home" data-transition="pop" data-role="button">Review it!</a>
   </div>
</div>
<!-- Incorrect Page-->

<!-- Done Page-->
<div data-role="page" id="done">
  <div data-role="header" data-theme="d">
    <h1>Done</h1>
  </div>
  <div data-role="content" data-theme="c">
    <p style="text-align: center; color:green;"><b>Completed!</b></p>
    <a href="#" data-rel="back" data-icon="back" data-role="button">Back</a>
    <a href="review.html" data-icon="home" data-transition="pop" data-role="button">Review it!</a>
}
AcingAP.footer(true)
puts %{
<!-- Done Page-->
</div>
</body>
</html>
}

