require 'cinch'

class LunchRoulette
  include Cinch::Plugin

  match /lunchroulette (.+)/

  @@VENUES = {
    "w1" => [
      "Leon", "Pret", "Eat",
      "Kaffiene", "Boots", "the pub"
    ],
    "w12" => [
      "the canteen", "Tesco", "Davy's",
      "Gourmet Burger Kitchen", "Busaba Eathai",
      "the pub"
    ],
    "salford" => [
      "the canteen", "Wagamama", "Booths",
      "you must go swimming in the canal instead of lunch"
    ]
  }

  def execute(m, area)
    if @@VENUES.has_key? area
      venue = @@VENUES[area].sample
      if venue.include? 'canal'
        m.reply "#{m.user.nick}, #{venue}"
      else
        m.reply "#{m.user.nick}, you must lunch at #{venue}."
      end
    else
      m.reply "I'm sorry #{m.user.nick}, I'm not aware of #{area}."
    end
  end
end
