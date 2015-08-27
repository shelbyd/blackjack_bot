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

  withAce: => @addCard_ 'ace'
  withTwo: => @addCard_ 'two'
  withThree: => @addCard_ 'three'
  withFour: => @addCard_ 'four'
  withFive: => @addCard_ 'five'
  withSix: => @addCard_ 'six'
  withSeven: => @addCard_ 'seven'
  withEight: => @addCard_ 'eight'
  withNine: => @addCard_ 'nine'
  withTen: => @addCard_ 'ten'

  addCard_: (cardName) =>
    cards = {}
    cards[name] = @cards[name] for name in RANKS
    cards[cardName] += 1
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
