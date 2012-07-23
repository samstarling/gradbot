require 'rest-client'
require 'cinch'
require 'json'

class Karma
	include Cinch::Plugin

	match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
	match /([\w]+)--/, method: :remove_karma, use_prefix: false

	def add_karma(m, arg)
		load_hash
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] += 1
		m.reply "Gave more karma to \"#{arg}\". New karma: #{val}"
		save_hash
	end

	def remove_karma(m, arg)
		load_hash
		@karma[arg.to_sym] ||= 0
		val = @karma[arg.to_sym] -= 1
		m.reply "Took karma away from \"#{arg}\". New karma: #{val}."
		save_hash
	end
	
	def load_hash
    if File.exists?('karma')
      @karma = Marshal.load(f)
    else
      @karma = Hash.new
			File.new('karma', 'w')
      File.open('karma', 'w+') do |f|
			  Marshal.dump(@karma, f)
		  end
    end
  end

  def save_hash
    File.open('karma', 'w+') do |f|
      Marshal.dump(@karma, f)
    end
  end
end
