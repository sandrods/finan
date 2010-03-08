# Install hook code here

require 'ftools'

this_dir = File.dirname(__FILE__)
root_dir = File.join(this_dir, '..', '..', '..')

File.copy File.join(this_dir, 'public', 'active.png'), File.join(root_dir, 'public', 'images', 'active.png')
File.copy File.join(this_dir, 'public', 'menu.css'), File.join(root_dir, 'public', 'stylesheets', 'menu.css')
