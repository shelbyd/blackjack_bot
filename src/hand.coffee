class Hand
  RANK_VALUES =
    two: 2
    three: 3
    four: 4
    five: 5
    six: 6
    seven: 7
    eight: 8
    nine: 9
    ten: 10

  constructor: (@cardList) ->

  value: =>
    result = 0
    for name, value of RANK_VALUES
      result += value * @cardList["#{name}s"]()

    if @cardList.aces()
      for ace in [1..@cardList.aces()]
        result += 11
        if result > 21
          result -= 10

    result

  bust: => @value() > 21

  blackjack: => @cardList.aces() == 1 && @cardList.tens() == 1
