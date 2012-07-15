require 'rest-client'
require 'cinch'
require 'json'

class Karma
	include Cinch::Plugin

	match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
	match /([\w]+)--/, method: :remove_karma, use_prefix: false

	def add_karma(m, arg)
		@karma ||= Hash.new
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] += 1
		m.reply "Gave more karma to \"#{arg}\". New karma: #{val}"
	end

	def remove_karma(m, arg)
		@karma ||= Hash.new
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] -= 1
		m.reply "Took karma away from \"#{arg}\". New karma: #{val}."
	end
end
