# Install hook code here
require 'ftools'

this_dir = File.dirname(__FILE__)
root_dir = File.join(this_dir, '..', '..', '..')

File.copy File.join(this_dir, 'public', 'javascripts', 'jquery.autocomplete.js'), File.join(root_dir, 'public', 'javascripts', 'jquery.autocomplete.js')
puts "[jquery.autocomplete.js] copied."

File.copy File.join(this_dir, 'public', 'javascripts', 'jquery.js'), File.join(root_dir, 'public', 'javascripts', 'jquery.js')
puts "[jquery.js] copied."

File.copy File.join(this_dir, 'public', 'stylesheets', 'jquery.autocomplete.css'), File.join(root_dir, 'public', 'stylesheets', 'jquery.autocomplete.css')
puts "[jquery.css] copied."

File.copy File.join(this_dir, 'public', 'images', 'indicator.gif'), File.join(root_dir, 'public', 'images', 'indicator.gif')
puts "[indicator.js] copied."