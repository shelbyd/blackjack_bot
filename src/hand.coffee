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
    ace: 11

  constructor: (@cardList) ->

  value: =>
    result = @rawValue_()

    if @cardList.aces()
      for ace in [1..@cardList.aces()]
        result -= 10 if result > 21

    result

  rawValue_: =>
    result = 0
    for name, value of RANK_VALUES
      result += value * @cardList["#{name}s"]()
    result

  bust: => @value() > 21

  blackjack: => @cardList.aces() == 1 && @cardList.tens() == 1

  isSoft: => not not @cardList.aces() and @rawValue_() <= 21
