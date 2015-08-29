class Count
  @multiplier: (shoe) ->
    count = @count_(shoe)
    count / (shoe.cardCount() / 52) + 1

  @count_: (shoe) ->
    lowCards = shoe.twos() +
                shoe.threes() +
                shoe.fours() +
                shoe.fives() +
                shoe.sixes()
    highCards = shoe.tens() +
                shoe.aces()
    highCards - lowCards
