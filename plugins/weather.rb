#!/bin/env ruby
# encoding: utf-8

require 'rest-client'
require 'cinch'
require 'json'

class Weather
  include Cinch::Plugin

  LOCATIONS = {
    :london => 44418,
    :salford => 33887,
    :manchester => 28218,
    :miami => 2450022
  }
  
  match /weather (.+)/

  def location_to_id(location)
    LOCATIONS[location.strip.downcase.to_sym] || nil
  end

  def f_to_c f
    ((Integer(f) - 32) * (5.0 / 9)).floor
  end
  
  def execute(m, location)
    location_id = location_to_id location
    if location_id
      response = JSON.parse(RestClient.get "http://weather.yahooapis.com/forecastjson?w=#{location_id}")
      celsius = f_to_c response['condition']['temperature']
      m.reply "#{m.user.nick}: #{response['condition']['text']}, #{celsius}C"
    else
      m.reply "#{m.user.nick}: I'm not aware of '#{location}'"
  end
end
