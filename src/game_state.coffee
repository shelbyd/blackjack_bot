class GameState
  constructor: (@my, @dealer, @unseen) ->

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

  hitAllowed: =>
    !@lost() and @unseen.cardCount() != 0 and !@myHand().blackjack()

  doubleAllowed: =>
    @my.cardCount() == 2 and @hitAllowed()

  splitAllowed: =>
    return false unless @doubleAllowed()

    return true for card, value of @my.cards when value == 2

    false
