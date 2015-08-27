class GameState
  constructor: (@my, @dealer, @unseen) ->

  expectedValue: =>
    return -1 if @lost()
    if @won()
      return 1.5 if @myHand().blackjack()
      return 1
    return 0 if @push()

    return -Infinity if @unseen.cardCount() == 0

    # console.log 'Calculating EV of', @my.toString(), @dealer.toString()
    expected = 0
    for name, value of @unseen.cards
      continue if @unseen.cardCount(name) == 0
      expected += new GameState(@my, @dealer.addCard(name), @unseen.removeCard(name)).expectedValue() * value
    expected / @unseen.cardCount()

  won: =>
    @over() and not @lost() and not @push()

  over: =>
    @dealer.cardCount() >= 2 and
    @dealerHand().value() >= 17

  lost: =>
    return true if @myHand().bust()
    @myHand().value() < @dealerHand().value() and
    not @dealerHand().bust()

  push: =>
    @over() and
    @myHand().value() == @dealerHand().value() and
    not @myHand().bust()

  dealerHand: => new Hand(@dealer)

  myHand: => new Hand(@my)

  bestPlay: => @bestPlayAndExpectedValue()[0]

  expectedValueOfBestPlay: => @bestPlayAndExpectedValue()[1]

  bestPlayAndExpectedValue: =>
    stand = @standExpectedValue()
    hit = @hitExpectedValue()
    double = @doubleExpectedValue()

    if stand > hit and stand > double
      ['stand', stand]
    else if hit > double
      ['hit', hit]
    else
      ['double', double]

  standExpectedValue: => @expectedValue()

  hitExpectedValue: =>
    return -Infinity if @lost() or @unseen.cardCount() == 0
    result = 0
    for name, value of @unseen.cards
      continue if value == 0
      result += new GameState(@my.addCard(name), @dealer, @unseen.removeCard(name)).expectedValueOfBestPlay() * value
    result / @unseen.cardCount()

  doubleExpectedValue: =>
    return -Infinity if @my.cardCount() > 2 or @unseen.cardCount() == 0
    result = 0
    for name, value of @unseen.cards
      continue if value == 0
      result += new GameState(@my.addCard(name), @dealer, @unseen.removeCard(name)).standExpectedValue() * value
    2 * result / @unseen.cardCount()
