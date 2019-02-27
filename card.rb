# Class that determines a game card object
class Card
  attr_reader :value

  LEARS = { spades: '♠', hearts: '♥', diamonds: '♦', clubs: '♣' }.freeze
  VALUES = {
    ace: 'A', two: '2', three: '3', four: '4', five: '5',
    six: '6', seven: '7', eight: '8', nine: '9', ten: '10',
    jack: 'J', queen: 'Q', king: 'K'
  }.freeze
  WEIGHTS = {
    two: 2, three: 3, four: 4, five: 5, six: 6,
    seven: 7, eight: 8, nine: 9, ten: 10,
    jack: 10, queen: 10, king: 10, ace: 1
  }.freeze

  def initialize(value, lear)
    @value = value
    @lear = lear
  end

  def to_s
    "#{VALUES[@value]}#{LEARS[@lear]}"
  end

  def ace?
    return true if @value == :ace

    false
  end
end
