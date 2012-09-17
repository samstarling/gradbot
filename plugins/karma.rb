require 'rest-client'
require 'cinch'
require 'json'

class Karma
  include Cinch::Plugin
  
  attr_reader :karma
  
  @@filepath = '/home/samstarling/temp/karma.marshal'
  
  match /karma/
  match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
  match /([\w]+)--/, method: :remove_karma, use_prefix: false
  listen_to :connect
  
  def execute(m)
    load_hash
    @karma.sort_by {|key, value| value}
    @karma.each do |k, v|
      if v != 0
        m.reply "#{k} has #{v} karma"
      end
    end
  end
  
  def add_karma(m, arg)
    load_hash
    @karma[arg.to_sym] ||= 0
    val = @karma[arg.to_sym] += 1
    noise = ["Boom", "Ping", "Bam", "Smash", "Wahey", "Yay"].sample
    m.reply "#{noise}! #{m.user.nick} gave more karma to \"#{arg}\". New karma: #{val}"
    save_hash
  end

  def remove_karma(m, arg)
    load_hash
    @karma[arg.to_sym] ||= 0
    val = @karma[arg.to_sym] -= 1
    noise = ["Oh dear", "O noes", "Erk", "Oops", "Sadface"].sample
    m.reply "#{noise}. #{m.user.nick} took karma away from \"#{arg}\". New karma: #{val}."
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
