class CardList
  RANKS = [
    'ace'
    'two'
    'three'
    'four'
    'five'
    'six'
    'seven'
    'eight'
    'nine'
    'ten'
  ]

  constructor: (cards) ->
    @cards = cards || {}
    @cards[name] = @cards[name] || 0 for name in RANKS

  withAce: => @addCard 'ace'
  withTwo: => @addCard 'two'
  withThree: => @addCard 'three'
  withFour: => @addCard 'four'
  withFive: => @addCard 'five'
  withSix: => @addCard 'six'
  withSeven: => @addCard 'seven'
  withEight: => @addCard 'eight'
  withNine: => @addCard 'nine'
  withTen: => @addCard 'ten'

  addCard: (cardName) =>
    cards = {}
    cards[name] = @cards[name] for name in RANKS
    cards[cardName] += 1
    new CardList(cards)

  removeCard: (cardName) =>
    cards = {}
    cards[name] = @cards[name] for name in RANKS
    cards[cardName] -= 1
    new CardList(cards)

  aces: => @cards.ace
  twos: => @cards.two
  threes: => @cards.three
  fours: => @cards.four
  fives: => @cards.five
  sixs: => @cards.six
  sevens: => @cards.seven
  eights: => @cards.eight
  nines: => @cards.nine
  tens: => @cards.ten

  cardCount: (name) =>
    if name
      @cards[name]
    else
      result = 0
      result += @cards[name] for name in RANKS
      result

  toString: =>
    result = {}
    result[name] = @cards[name] for name in RANKS when @cards[name]
    result
