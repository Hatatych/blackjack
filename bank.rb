require_relative './game_rules.rb'

# This class handles game bank and all financial operations
class Bank
  attr_reader :bank

  def initialize
    @bank = 0
  end

  def bet(player, bet = GameRules::DEFAULT_BET)
    player.withdraw(bet)
    @bank += bet
  end

  def reward(player)
    player.add_money(@bank)
    @bank = 0
  end

  def refund(player, dealer)
    player.add_money(@bank / 2)
    dealer.add_money(@bank / 2)
    @bank = 0
  end
end
