require "rexml/document"
#<!ELEMENT glossary (word+)>
#<!ELEMENT word (id, title, description, example*)>  example is optional

filename = "../kb/glossary.xml"
file = File.new(filename)
doc = REXML::Document.new file
words_array = doc.elements.to_a("glossary/word")
for i in 0...words_array.size do
  p words_array[i].elements['title'].get_text
end

