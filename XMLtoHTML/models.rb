require "rexml/document"
# <!ELEMENT models (model)+>'
# <!ELEMENT model (id, title, image?, description)>'

filename = "../kb/models.xml"
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
  <!--Menu Start-->
  <div data-role="page" id="models">
    <div data-role="content" data-theme="a">
      <h3>Models</h3>
     }
#we will have to traverse twice, first to provide the links and second will have the description
doc.elements.each("models/model") do |model_element|
  id = model_element.elements['id'].text
  title = model_element.elements['title'].text
  puts "<a href=\"##{id}\" data-role=\"button\" data-transition=\"pop\" data-theme=\"c\">#{title}</a>"
end
puts %{
      <a href="#" data-role="button" data-rel="back" data-theme="a">Back</a>
    </div>
  </div>
  <!--Menu End-->
  <!--Actual Models Start-->
     }
#get the array this time, as we need to create link to the next model
model_array = doc.elements.to_a("models/model")
for i in 0...model_array.size do
  if (i < (model_array.size - 1))
    next_model_exists = true
  else
    next_model_exists = false
  end
  id = model_array[i].elements['id'].text
  title = model_array[i].elements['title'].text
  begin
    image = model_array[i].elements['image'].text.to_s
  rescue
    image = nil
  end
  des = model_array[i].elements['description'].text
  puts %{
  <div data-role="page" id="#{id}" data-theme="c">
    <div data-role="header" data-theme="c" data-position="fixed">
      <a href="learn.html" data-icon="home" data-transition="pop" data-ajax="false">Learn it!</a>
      <h1>Models</h1>
      <div data-role="navbar">
        <ul>
          <li><a href="#" data-rel="back">Back</a></li>
  }
  if next_model_exists
    sibling_id = model_array[i+1].elements['id'].text
    puts %{
          <li><a href="##{sibling_id}">Next</a></li>
    }
  end
  puts %{
        </ul>
      </div>
    </div>
    <div data-role="content" data-theme="c">
      <h1>#{title}</h1>
  }
  if !image.nil?
    puts %{
      <img src="#{image}" alt="#{title}"  style="width: 100%"/>
    }
  end
  puts %{
      <p style="margin-left: 10px; margin-right: 10px;">#{des}</p>
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