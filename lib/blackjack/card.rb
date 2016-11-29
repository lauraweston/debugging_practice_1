class Card
  def self.create(symbol)
    self.card_creators[symbol].new(symbol)
  end

  def self.random
    self.create(card_creators.keys.sample)
  end

  def self.register_card_creator(symbol, card_class)
    @@card_creators[symbol] = card_class
  end

  @@card_creators = {}

  def self.card_creators
    @@card_creators
  end
end
