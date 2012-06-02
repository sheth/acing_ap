require "rexml/document"
#<!ELEMENT glossary (word+)>
#<!ELEMENT word (id, title, description, example*)>  example is optional

filename = "../kb/glossary.xml"
file = File.new(filename)
doc = REXML::Document.new file
puts %{
<!DOCTYPE html>
<html>
	<head>
	<title>Acing AP Human Geography</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/themes/default/jquery.mobile-1.1.0.min.css" />
	<script src="js/jquery-1.7.1.min.js"></script>
	<script src="js/jquery.mobile-1.1.0.min.js"></script>
</head>
<body>
<!--Glossary-->
<div data-role="page" id="glossary" data-theme="c">
  <div data-role="header" data-theme="c" data-position="fixed">
    <a href="learn.html" data-ajax="false" data-icon="home" data-transition="pop">Learn it!</a>
    <h1>Glossary</h1>
  </div>
	<div data-role="content" data-theme="c">
	  <p>The vocabulary and terminology used throughout the course is one of the best reviews for the test. Check to see if you know all these words!</p>
	  <ul data-role="listview" data-theme="d" data-filter="true" data-dividertheme="a">
}
#will have to run through it twice, once for menu and other for the actual words and its meaning.
words_array = doc.elements.to_a("glossary/word")
for i in 0...words_array.size do
  glossary_id = words_array[i].elements['id'].text
  title = words_array[i].elements['title'].text
  if (i > 0)
    prev_title = words_array[i-1].elements['title'].text
  else
    prev_title = nil
  end
  if ((i == 0) || (!title[0].eql? prev_title[0]))
    list_divider = title[0].capitalize
    puts %{
      <li data-role="list-divider">#{list_divider}</li>
    }
  end
  puts %{
        <li><a href="##{glossary_id}">#{title}</a></li>
  }
end
puts %{
    </ul>
  </div>
  <div data-role="footer" data-position="fixed" data-id="mainFooter">
    <div data-role="navbar" data-iconpos="top">
      <ul>
        <li><a href="learn.html" data-ajax="false" data-icon="grid" data-theme="c">Learn it!</a></li>
        <li><a href="review.html" data-ajax="false" data-icon="star">Review it!</a></li>
        <li><a href="take.html" data-ajax="false" data-icon="check">Take it!</a></li>
      </ul>
    </div>
  </div> 
</div>
<!-- Glossary Words / Terms Pages-->
}
for i in 0...words_array.size do
  glossary_id = words_array[i].elements['id'].text
  title = words_array[i].elements['title'].text
  description = words_array[i].elements['description'].text
  puts %{
<div data-role="page" data-theme="c" id="#{glossary_id}">
  <div data-role="header" data-theme="c" data-position="fixed">
    <a href="learn.html" data-icon="home" data-ajax="false" data-transition="pop">Learn it!</a>
    <h1>Glossary</h1> <a href="#" data-rel="back" data-icon="back" data-transition="pop">Back</a>
  </div>
  <div data-role="content" data-theme="c">
    <h1>#{title}</h1>
    <p style="margin-left: 10px; margin-right: 10px;">#{description}</p>
  }
  words_array[i].each_element_with_text do |e|
    if (e.name.eql?("example"))
      puts %{
    <p style="margin-left: 10px; margin-right: 10px;"><em>#{e.text}</em></p>
      }
    end
  end
  puts %{
  </div>
  <div data-role="footer" data-position="fixed" data-id="mainFooter">
    <div data-role="navbar" data-iconpos="top">
      <ul>
        <li><a href="learn.html" data-ajax="false" data-icon="grid" data-theme="c">Learn it!</a></li>
        <li><a href="review.html" data-ajax="false" data-icon="star">Review it!</a></li>
        <li><a href="take.html" data-ajax="false" data-icon="check">Take it!</a></li>
      </ul>
    </div>
  </div> 
</div>
  }
end
puts %{
</body>
</html>
}

