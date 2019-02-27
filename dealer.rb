require_relative './player.rb'

# This is a dealer
class Dealer < Player
  attr_writer :opened_cards

  def initialize(name = 'Dealer')
    @opened_cards = false
    super
  end

  def to_s
    if !@opened_cards
      'Ты не видишь карт дилера'
    else
      super
    end
  end
end
