#!/usr/bin/ruby

require 'json'
require 'date'
require 'time'

i = 0

File.open("bulk.json", 'wb') do |io|
  ARGF.each do |line|
  	i += 1
  	action = { index: { _index: "test_audio_stats", _id: i } }
    io.write(action.to_json + "\n")
    io.write(line)
  end
end

