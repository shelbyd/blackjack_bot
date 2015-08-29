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

  @shoe: (deckCount)->
    new CardList
      ace: 4 * deckCount
      two: 4 * deckCount
      three: 4 * deckCount
      four: 4 * deckCount
      five: 4 * deckCount
      six: 4 * deckCount
      seven: 4 * deckCount
      eight: 4 * deckCount
      nine: 4 * deckCount
      ten: 16 * deckCount

  @fromList: (list) ->
    object = {}
    for item in list
      object[item] = object[item] || 0
      object[item] += 1
    new CardList(object)

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
  sixes: => @cards.six
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
    JSON.stringify(result)

  getCards: =>
    result = []
    for name in RANKS
      if @cards[name]
        result.push name for index in [1..@cards[name]]
    result
