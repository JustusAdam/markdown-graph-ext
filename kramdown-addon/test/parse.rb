$:.unshift File.dirname(__FILE__) + '/../src'
$:.unshift File.dirname(__FILE__) + '/../kramdown-source/lib'

require 'kramdown/document'
require 'graph-ext'

input_text = """
# heading
test

v[hello]: world
"""


Kramdown::Document.new(input_text, :input => 'GraphParser').to_html
