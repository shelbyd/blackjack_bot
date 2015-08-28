shuffle = (array) ->
  counter = array.length

  while (counter > 0)
    index = Math.floor(Math.random() * counter)
    counter -= 1
    temp = array[index]
    array[index] = array[counter]
    array[counter] = temp

  array

class BetCalculator
  TIME_TO_CALCULATE = 10000

  @expectedValue: (shoe) =>
    startTime = new Date().getTime()

    toEval = []
    for myCardOne, myCardOneCount of shoe.cards
      continue if myCardOneCount == 0
      newShoe = shoe.removeCard(myCardOne)
      for myCardTwo, myCardTwoCount of newShoe.cards
        continue if myCardTwoCount == 0
        newestShoe = newShoe.removeCard(myCardTwo)
        for dealerCard, dealerCardCount of newestShoe.cards
          continue if dealerCardCount == 0
          return 0 if (new Date().getTime() - startTime) > TIME_TO_CALCULATE
          toEval.push
            myCardOne: myCardOne
            myCardTwo: myCardTwo
            dealerCard: dealerCard
            weight: myCardOneCount * myCardTwoCount * dealerCardCount

    toEval.sort (a, b) -> a.weight - b.weight

    ev = 0
    evaled = 0
    while (toEval.length and (new Date().getTime() - startTime) < TIME_TO_CALCULATE)
      thisEval = toEval.pop()
      evaled += thisEval.weight
      gameState = new GameState(
                      new CardList().addCard(thisEval.myCardOne).addCard(thisEval.myCardTwo),
                      new CardList().addCard(thisEval.dealerCard),
                      shoe.removeCard(thisEval.myCardOne)
                          .removeCard(thisEval.myCardTwo)
                          .removeCard(thisEval.dealerCard))
      value = ExpectedValue.expectedValueOfBestPlay(gameState) * thisEval.weight
      ev += value

    ev / evaled
