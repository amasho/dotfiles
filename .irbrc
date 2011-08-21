require 'rubygems'
require 'active_support'
require 'pp'
require 'irb/completion'
require 'what_methods'
require 'wirble'

IRB.conf[:AUTO_INDENT]=true
IRB.conf[:SAVE_HISTORY]=200

Wirble.init
Wirble.colorize
