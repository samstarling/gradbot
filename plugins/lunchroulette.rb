class LunchVenueData
  def self.get area
    venues = {
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
        "the canteen", "Wagamama", "Booths", "canal"
      ]
    }
    if venues[area]
      venues[area].sample
    else
      nil
    end
  end
end

class LunchRoulette
  include Cinch::Plugin

  match /lunchroulette (.+)/

  def execute(m, area)
    venue = LunchVenueData.get area
    if venue
      if venue.include? 'canal'
        m.reply "#{m.user.nick}, you must go swimming in the canal instead of lunch."
      else
        m.reply "#{m.user.nick}, you must lunch at #{venue}."
      end
    else
      m.reply "I'm sorry #{m.user.nick}, I'm not aware of #{area}."
    end
  end
end
