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
      "У дилера #{@hand.cards.length} карты, но ты их не видишь"
    else
      super
    end
  end

  def can_take_card?
    score < GameRules::DEALER_DUMMY_SCORE && !full_hand?
  end
end
