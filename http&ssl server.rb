#!/usr/bin/env ruby
=begin
Copyright (C) 2019 Grathium Industries <GrathiumIndustries@gmail.com>
This program comes with ABSOLUTELY NO WARRANTY
This is a free software, and you are welcome to redistribute it under certain
conditions.
=end

require 'net/http'
require 'webrick'
require 'webrick/https'
require 'securerandom'

def readFile
  @temps = ''
  File.foreach("index.html") { |line| @temps += line }
  return @temps
end

class Webbrowser

	def local_server()
		cert_name = [
			%w[CN localhost],
		]

		server = WEBrick::HTTPServer.new(
			:Port => 8080,
			:SSLEnable => false, # change this for https:// support
			:SSLCertName => cert_name
		)

		server.mount_proc '/' do |req, res|
			res.body = readFile()
		end

		puts "\nClient Ready!"
		server.start
	end

end

w = Webbrowser.new
w.local_server()
