$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Ruxu
  VERSION = '0.0.1'
end

require 'socket'
require 'forwardable'
require 'ruxu/runner'
require 'ruxu/server'
require 'ruxu/connection'
require 'ruxu/exceptions'
