require 'rest-client'
require 'cinch'
require 'json'

class Karma
	include Cinch::Plugin

	match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
	match /([\w]+)--/, method: :remove_karma, use_prefix: false

	def add_karma(m, arg)
		@karma ||= load_hash
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] += 1
		m.reply "Gave more karma to \"#{arg}\". New karma: #{val}"
		save_hash
	end

	def remove_karma(m, arg)
		@karma ||= load_hash
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] -= 1
		m.reply "Took karma away from \"#{arg}\". New karma: #{val}."
		save_hash
	end
	
	def load_hash
		@karma ||= Hash.new
		save_hash
		File.open('karma') do |f|
			@karma = Marshal.load(f)
		end
		return @karma
	end
	
	def save_hash
		unless File.exists?('karma')
			File.new('karma', 'w')
		end
		File.open('karma', 'w+') do |f|
			Marshal.dump(@karma, f)
		end
	end
end
