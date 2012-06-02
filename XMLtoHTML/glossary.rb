require "rexml/document"
require "./AcingAP"

#<!ELEMENT glossary (word+)>
#<!ELEMENT word (id, title, description, example*)>  example is optional
filename = "../kb/glossary.xml"
file = File.new(filename)
doc = REXML::Document.new file
AcingAP.open_head
puts %{
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
}
AcingAP.footer
puts %{
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
  AcingAP.footer
end
puts %{
</body>
</html>
}

