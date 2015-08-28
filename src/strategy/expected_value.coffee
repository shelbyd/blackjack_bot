expectedValueCache = {}

expectedValue_ = (gameState) ->
  my = gameState.my
  dealer = gameState.dealer
  unseen = gameState.unseen

  key = "#{my.toString()}#{dealer.toString()}#{unseen.toString()}"
  if not expectedValueCache[key]
    expected = 0
    for name, value of unseen.cards
      continue if unseen.cardCount(name) == 0
      expected += ExpectedValue.expectedValue(new GameState(my, dealer.addCard(name), unseen.removeCard(name))) * value
    expectedValueCache[key] = expected / unseen.cardCount()
  expectedValueCache[key]

class ExpectedValue
  @expectedValue: (gameState) ->
    return -1 if gameState.lost()
    return 0 if gameState.push()
    if gameState.won()
      return 1.5 if gameState.myHand().blackjack()
      return 1
    return -Infinity if gameState.unseen.cardCount() == 0

    expectedValue_ gameState

  @bestPlay: (gameState) -> @bestPlayAndExpectedValue(gameState).action

  @expectedValueOfBestPlay: (gameState) -> @bestPlayAndExpectedValue(gameState).ev

  @bestPlayAndExpectedValue: (gameState) ->
    ev = {}
    ev.stand = @standExpectedValue(gameState)
    ev.hit = @hitExpectedValue(gameState)
    ev.double = @doubleExpectedValue(gameState)

    best = ev: -Infinity
    for key, value of ev when value > best.ev
      best =
        action: key
        ev: value

    best

  @standExpectedValue: (gameState) -> @expectedValue(gameState)

  @hitExpectedValue: (gameState) ->
    return -Infinity if gameState.lost() or gameState.unseen.cardCount() == 0
    result = 0
    for name, value of gameState.unseen.cards
      continue if value == 0
      result += @expectedValueOfBestPlay(@afterIDraw(gameState, name)) * value
    result / gameState.unseen.cardCount()

  @afterIDraw: (gameState, name) ->
    new GameState(gameState.my.addCard(name), gameState.dealer, gameState.unseen.removeCard(name))

  @doubleExpectedValue: (gameState) ->
    return -Infinity if gameState.my.cardCount() > 2
    2 * @hitExpectedValue(gameState)
