require 'sinatra'
require File.join(File.dirname(__FILE__), 'app')

run EcommerceApp.new
