time = (name, f) ->
  start = new Date().getTime()
  f()
  done = new Date().getTime()
  console.log "#{name} took #{done - start}ms"

shoe = CardList.shoe(6)

time 'Tens', ->
  hand = new CardList().withTen().withTen()
  dealer = new CardList().withSeven()
  innerShoe = shoe.removeCard('ten').removeCard('ten').removeCard('seven')
  play = ExpectedValue.bestPlay(new GameState(hand, dealer, innerShoe))
  console.log "Play is: #{play}"

time 'Aces', ->
  hand = new CardList().withAce().withAce()
  dealer = new CardList().withSeven()
  innerShoe = shoe.removeCard('ace').removeCard('ace').removeCard('seven')
  play = ExpectedValue.bestPlay(new GameState(hand, dealer, innerShoe))
  console.log "Play is: #{play}"
