# This class is a handler for game logic and managing turns
class GameHandler
  attr_reader :pile, :ai_player, :person_player

  def initialize(player_name)
    @in_progress = false
    @pile = Pile.new
    @ai_player = Dealer.new(self)
    @person_player = Player.new(self, player_name)
  end

  def start
    @in_progress = true # Ostanovilsya tut
  end

  def skip_turn; end

  def add_card; end

  def open_cards; end
end
