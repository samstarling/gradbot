require 'rest-client'
require 'cinch'
require 'json'

class KarmaData
  attr_accessor :data 

  def initialize
    @filepath = ENV['karma_file'] || '/home/samstarling/temp/karma.marshal'
    load
  end

  def remove_file
    `rm #{@filepath}`
    load
  end

  def save
    File.open(@filepath, 'w') do |f|
      Marshal.dump(@data, f)
    end
  end

  def regroup
    regrouped = Hash.new
    @data.each do |thing, score|
      (regrouped[score] ||= []) << thing if score != 0
    end
    regrouped
  end

  def reset
    @data = Hash.new
    save
  end
  
  private
  
  def load
    if File.exists?(@filepath)
      File.open(@filepath) do |f|
        @data = Marshal.load(f)
      end
    else
      reset
    end
  end
end

class Karma
  include Cinch::Plugin

  match /karma/
  match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
  match /([\w]+)--/, method: :remove_karma, use_prefix: false
  match /([\w]+)\+=(\d+)/, method: :add_karma, use_prefix: false
  match /([\w]+)-=(\d+)/, method: :remove_karma, use_prefix: false
  listen_to :connect
  listen_to :join, method: :startup

  def startup(m=nil)
    @data_source = KarmaData.new
  end

  def get_value thing
    @data_source.data[thing]
  end

  def execute(m)
    @data_source.regroup.each do |score, things|
      possession = if things.size == 1 then "has" else "have" end
      thing_list = to_sentence things
      m.reply "#{thing_list} #{possession} #{score} karma"
    end
  end

  def to_sentence things
    if things.size == 1
      things.join ", "
    else
      start = things[0..-2].join ", "
      finish = things[-1]
      "#{start} and #{finish}"
    end
  end

  def reset_karma
    @data_source.reset
  end
  
  def modify_karma(m, thing, count)
    thing.downcase!
    @data_source.data[thing.to_sym] ||= 0
    val = @data_source.data[thing.to_sym] += count
    @data_source.save
    return val
  end

  def add_karma(m, thing, count=1)
    val = modify_karma m, thing, count.to_i
    noise = ["Boom", "Awesome", "Mint", "Yay"].sample
    action = "#{m.user.nick} gave more karma to \"#{thing}\""
    m.reply "#{noise}! #{action}. New karma: #{val}"
  end

  def remove_karma(m, thing, count=1)
    val = modify_karma m, thing, -count.to_i
    noise = ["Oh dear", "O noes", "Erk", "Sadface"].sample
    action = "#{m.user.nick} took karma away from \"#{thing}\""
    m.reply "#{noise}. #{action}. New karma: #{val}."
  end
end