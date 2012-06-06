require "rexml/document"
require "./AcingAP"

#<!ELEMENT units (unit+)>
#<!ELEMENT unit (id, title, section+)+>
#<!ELEMENT section (id, title, description+)>
filename = "../kb/units.xml"
file = File.new(filename)
doc = REXML::Document.new file
AcingAP.open_head
puts %{
</head>
<body>
<div id="full">
<div data-role="page" id="menu" data-theme="a">
   <div data-role="header" data-theme="a">
      <h1>Learn it!</h1>
   </div>
   <div data-role="content" data-theme="a">
      <!--Menu Start-->
      <ul data-role="listview" data-theme="a">
     }
#we will have to traverse thrice, first to provide the menus and
#second will sections menu and third will have the actual section descriptions
unit_array = doc.elements.to_a("units/unit/")
for i in 0...unit_array.size do
  unit_id = unit_array[i].elements['id'].text
  unit_title = unit_array[i].elements['title'].text
  puts %{ <li><a href="##{unit_id}" data-rel="dialog"><h3>#{unit_title}</h3></a></li> }
end
puts %{
 <li data-theme="d"><a href="models.html" data-rel="dialog" data-ajax="false"><h3>Models</h3></a></li>
 <li data-theme="d"><a href="glossary.html" data-ajax="false"><h3>Glossary</h3></a></li> 
      </ul>
      <!--Menu End-->
}
AcingAP.footer
# second time for section menu
section_array = doc.elements.to_a("units/unit/section")
for i in 0...unit_array.size do
  unit_id = unit_array[i].elements['id'].text
  unit_title = unit_array[i].elements['title'].text
  puts %{
<div data-role="page" id="#{unit_id}">
  <div data-role="content" data-theme="d">
    <h3>#{unit_title}</h3>
  }
  for j in 0...section_array.size do
    section_id = section_array[j].elements['id'].text
    section_title = section_array[j].elements['title'].text
    parent_title = section_array[j].elements['../title'].text
    if (parent_title.eql? unit_title)
      puts %{
      <a href="##{section_id}" data-role="button" data-transition="pop" data-theme="a">#{section_title}</a>
      }
    else
      next
    end
  end

  puts %{
    <a href="#" data-role="button" data-rel="back" data-theme="d">Back</a>
   </div>
</div>
  }
end
#third time for the actual section descriptions
for i in 0...unit_array.size do
  unit_title = unit_array[i].elements['title'].text
  for j in 0...section_array.size do
    section_id = section_array[j].elements['id'].text
    section_title = section_array[j].elements['title'].text
    section_description = section_array[j].elements['description'].text
    parent_title = section_array[j].elements['../title'].text
    if (parent_title.eql? unit_title)
      puts %{
<div data-role="page" id="#{section_id}" data-theme="a">
  <div data-role="header" data-theme="a" data-position="fixed">
    <a href="learn.html" data-icon="home" data-transition="pop">Learn it!</a>
    <h1>#{parent_title}</h1>
    <div data-role="navbar">
      <ul>
        <li><a href="#" data-rel="back">Back</a></li>
      }
      if (j + 1 < section_array.size)
        #next link
        puts %{
          <li><a href="##{section_array[j+1].elements['id'].text}">Next</a></li>
        }
      else
        puts "<li><a href=\"#menu\">Next</a></li>"
      end
      puts %{
      </ul>
    </div>
  </div>
  <div data-role="content" data-theme="a">
    <h1>#{section_title}</h1>
      }
      #one section can have multiple descriptions.
      section_array[j].each_element_with_text do |e|
        if (e.name.eql?("description"))
          puts %{
    <p style="margin-left: 10px; margin-right: 10px;">#{e.text}</p>
          }
        end
      end
      AcingAP.footer
    else
      next
    end
  end
end
puts %{
</div>
</body>
</html>
}