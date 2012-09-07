require 'cinch'

class LunchRoulette
  include Cinch::Plugin

  match /lunchroulette (.+)/

  @@VENUES = {
    "w12" => ["Leon", "Pret", "Kaffiene", "Boots"],
    "w1" => ["Canteen", "Tesco", "Davy's", "Gourmet Burger Kitchen", "Busaba Eathai"],
    "salford" => ["Canteen", "Wagamama", "Booths", "You must go swimming in the canal instead of lunch"]
  }
  
  def execute(m, postcode)
    venue = @@VENUES[postcode].sample
    m.reply("#{m.user.nick}, you must lunch at '#{venue}'")
  end
end
