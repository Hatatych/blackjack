# Class that determines a game card object
class Card
  WEIGHTS = {
    two: 2, three: 3, four: 4, five: 5, six: 6,
    seven: 7, eight: 8, nine: 9, ten: 10,
    jack: 10, queen: 10, king: 10, ace: 1
  }.freeze
  LEAR_SYMBOLS = { spades: '♠', hearts: '♥', diamonds: '♦', clubs: '♣' }.freeze
  VALUE_SYMBOLS = {
    ace: 'A', two: '2', three: '3', four: '4', five: '5',
    six: '6', seven: '7', eight: '8', nine: '9', ten: '10',
    jack: 'J', queen: 'Q', king: 'K'
  }.freeze

  attr_reader :weight

  def initialize(value, lear)
    @value = value
    @lear = lear
    @weight = WEIGHTS[value]
  end

  def to_s
    "#{VALUE_SYMBOLS[@value]}#{LEAR_SYMBOLS[@lear]}"
  end
end
