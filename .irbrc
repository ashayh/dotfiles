# all gems must be installed, else silent fail
require 'rubygems'
require 'interactive_editor'

require 'ap' # Awesome Print
require 'net-http-spy' # Print information about any HTTP requests being made

require 'boson' # Load libraries from the Boson command framework

IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT]  = true

# Save History between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

require 'irbtools'
require 'irbtools/configure'
# Here you can modify the libraries using the methods below
Irbtools.start
