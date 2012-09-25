require 'rest-client'
require 'cinch'
require 'json'
require 'set'
require 'uri'

class CelebTracker
  include Cinch::Plugin
  
  attr_reader :celeb
  
  @@filepath = ENV['celeb_file'] || '/home/samstarling/temp/celeb.marshal'
  
  match /celeb/
  match /celeb (.+)/, method: :register_celeb, use_prefix: true
  listen_to :connect
  
  def execute(m)
    load_hash
    arr = @celeb.sort_by {|key, value| value[1]}.reverse()
    arr.each do |celeb, val|
      m.reply "#{titleise_name(celeb)} has been seen by \"#{human_readable_viewers(val[0])}\". #{titleise_name(celeb)} has a fame index of : #{val[1]}"
    end
  end
  
  def register_celeb(m, celeb_name)
    celeb_name.downcase!
    load_hash
    @celeb[celeb_name.to_sym] ||= Array[Set[], -1]
    seen_by = human_readable_viewers(@celeb[celeb_name.to_sym][0].add(m.user.nick))
    fame = @celeb[celeb_name.to_sym][1]
    if fame == -1
      fame = @celeb[celeb_name.to_sym][1] = calc_fame(celeb_name)
    end
    m.reply "#{titleise_name(celeb_name)} has been seen by \"#{seen_by}\". #{titleise_name(celeb_name)} has a fame index of : #{fame}"
    save_hash
  end

  def calc_fame(celeb_name)
    response = JSON.parse(RestClient.get "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=#{URI.escape(celeb_name.to_s)}")
    return response['responseData']['cursor']['estimatedResultCount'].to_i/1000
  end

  def human_readable_viewers(viewer_set)
    list = nil
    viewer_set.to_a.each do |viewer|
      if list === nil
        list = viewer
      else
        list = list + ", " + viewer
      end
    end
    return list
  end

  def titleise_name(name)
    split_name = name.to_s.split(" ")
    name = ""
    split_name.each do |word|
      name += word.capitalize + " "
    end
    return name.strip()
  end


  def load_hash
    if File.exists?(@@filepath)
      File.open(@@filepath) do |f|
        @celeb = Marshal.load(f)
      end
    else
      @celeb = Hash.new
      File.new(@@filepath, 'w')
      File.open(@@filepath, 'w+') do |f|
        Marshal.dump(@celeb, f)
      end
    end
  end

  def save_hash
    File.open(@@filepath, 'w+') do |f|
      Marshal.dump(@celeb, f)
    end
  end
end
