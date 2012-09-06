require 'rest-client'
require 'cinch'
require 'json'

class Karma
  include Cinch::Plugin
  
  @@filepath = '/home/samstarling/temp/karma.marshal'

  match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
  match /([\w]+)--/, method: :remove_karma, use_prefix: false

  match /karma/
  
  def execute(m)
    load_hash
    @karma.each do |k, v|
      m.reply "#{k} has #{v} karma"
    end
  end
  
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
    if File.exists?(@@filepath)
      File.open(@@filepath) do |f|
        @karma = Marshal.load(f)
      end
    else
      @karma = Hash.new
      File.new(@@filepath, 'w')
      File.open(@@filepath, 'w+') do |f|
        Marshal.dump(@karma, f)
      end
    end
  end

  def save_hash
    File.open(@@filepath, 'w+') do |f|
      Marshal.dump(@karma, f)
    end
  end
end
