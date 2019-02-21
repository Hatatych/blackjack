# This class handles AI player
class Dealer < Player
  def initialize(game)
    @opened_cards_flag = false
    super
  end
end
