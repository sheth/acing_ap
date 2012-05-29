require "rexml/document"
# <!ELEMENT models (model)+>'
# <!ELEMENT model (id, title, image?, description)>'

filename = "../../output/models.xml"
file = File.new(filename)
doc = REXML::Document.new file
puts %{
<div id="models">
  <div class="toolbar">
    <h1>Models</h1>
    <a href="#" class="back">Back</a>
  </div>
  <ul class="edgetoedge">
     }
#we will have to traverse twice, first to provide the links and second will have the description
doc.elements.each("models/model") do |model_element|
  id = model_element.elements['id'].get_text
  title = model_element.elements['title'].get_text
  puts "<li><a href=\"##{id}\">#{title}</a></li>"
end
puts %{
  </ul>
</div>
     }
doc.elements.each("models/model") do |model_element|
  id = model_element.elements['id'].get_text
  puts "<div id=\"#{id}\">"
  puts %{ <div class="toolbar">
            <h1>Models</h1>
              <a href="#" class="back">Back</a>
          </div>
          <div class="selectable">
       }
  title = model_element.elements['title'].get_text
  puts "    <h1 style=\"color:white\">#{title}l</h1> <br/>"
  begin
    image = model_element.elements['image'].get_text.to_s
  rescue
    image = nil
  end
  if !image.nil?
    puts "  <img src=\"#{image}\" alt=\"#{title}\" align=\"middle\"/>"
  end
  des = model_element.elements['description'].get_text
  puts "    <p style=\"margin-left: 10px; margin-right: 10px;\">#{des}</p>"
  puts "  </div>"
  puts "</div>"
end
