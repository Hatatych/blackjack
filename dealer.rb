require_relative './player.rb'

# That class inherits from player and contains minor stuff for displaying :)
class Dealer < Player
  attr_writer :opened_cards

  def initialize
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
