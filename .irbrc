require 'rubygems'
require 'interactive_editor'

require 'ap' # Awesome Print
require 'net-http-spy' # Print information about any HTTP requests being made

# ASCII table views
require 'hirb'
Hirb.enable
extend Hirb::Console

require 'boson' # Load libraries from the Boson command framework

IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT]  = true

# Save History between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Enable colored output
require 'wirble'
Wirble.init
Wirble.colorize
