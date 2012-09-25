require 'rest-client'
require 'cinch'
require 'json'

class Karma
  include Cinch::Plugin

  attr_reader :karma

  @@filepath = ENV['karma_file'] || '/home/samstarling/temp/karma.marshal'

  match /karma/
  match /([\w]+)\+\+/, method: :add_karma, use_prefix: false
  match /([\w]+)--/, method: :remove_karma, use_prefix: false
  listen_to :connect

  def execute(m)
    load_hash
    @karma.sort_by { |key, value| value }
    grouped = regroup_hash
    grouped.each do |score, things|
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
    @karma = Hash.new
    save_hash
  end

  def add_karma(m, arg)
    arg.downcase!
    load_hash
    @karma[arg.to_sym] ||= 0
    val = @karma[arg.to_sym] += 1
    noise = ["Boom", "Ping", "Bam", "Smash", "Wahey", "Yay"].sample
    action = "#{m.user.nick} gave more karma to \"#{arg}\""
    m.reply "#{noise}! #{action}. New karma: #{val}"
    save_hash
  end

  def remove_karma(m, arg)
    arg.downcase!
    load_hash
    @karma[arg.to_sym] ||= 0
    val = @karma[arg.to_sym] -= 1
    noise = ["Oh dear", "O noes", "Erk", "Oops", "Sadface"].sample
    action = "#{m.user.nick} took karma away from \"#{arg}\""
    m.reply "#{noise}. #{action}. New karma: #{val}."
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

  def regroup_hash
    regrouped = Hash.new
    @karma.each do |thing, score|
      if score != 0
        if !regrouped.has_key? score
          regrouped[score] = Array.new
        end
        regrouped[score] << thing
      end
    end
    regrouped
  end
end
