class Gambit
  VALUES =
    a: 'ace'
    2: 'two'
    3: 'three'
    4: 'four'
    5: 'five'
    6: 'six'
    7: 'seven'
    8: 'eight'
    9: 'nine'
    t: 'ten'
    j: 'ten'
    q: 'ten'
    k: 'ten'

  constructor: (@bettor, @strategy) ->

  run: =>
    @shoe = CardList.shoe(6)
    @hands = [[21, 22]]
    @currentHand = 0
    setInterval((=> @loop()), 1000)

  loop: =>
    if @remainingCardCount() == 312
      console.log 'Reshuffle!!!'
      @shoe = CardList.shoe(6)

    if @blueMessage() == 'Place Your Bet'
      @hands = [[21, 22]]
      @currentHand = 0
      @donePlaying = false

      @updateShoe()
      @bet()
    else if @blueMessage() == 'Do You Want Insurance?'
      $('.js-reject-insurance').click()
    else if @haveCards()
      @play()

  haveCards: =>
    @getMyCards().cardCount() and @getDealerCards().cardCount()

  getMyCards: =>
    @lastMyCards = @getCards (@hands[@currentHand] || [])
    @lastMyCards

  getCards: (ids) =>
    CardList.fromList(
        ids.map((id) => @getCard(id))
           .filter((card) -> card?))

  getCard: (id) =>
    cards = $("#card-#{id} .card-front")
    return unless cards.length

    cards.attr('class').split(/\s+/).map((className) =>
      VALUES[className.substr(5)]
    ).filter((value) => value?)[0]

  getDealerCards: =>
    @lastDealerCards =
      if @currentHand >= @hands.length
        @getCards [1, 2, 3, 4, 5, 6, 7, 99999]
      else
        @getCards [1, 2, 3, 4, 5, 6, 7]
    @lastDealerCards

  play: =>
    gameState = new GameState(@getMyCards(), @getDealerCards(), @liveShoe())
    play = @strategy.bestPlay(gameState)

    if play == 'stand'
      @currentHand += 1
      if @hands[@currentHand]?
        @hands[@currentHand].push(@currentCardNumber() + 1)
    else if play == 'split'
      card = @hands[@currentHand].pop()
      @hands[@currentHand].push(@currentCardNumber() + 1)
      @hands.push([card])
    else if play == 'hit'
      @hands[@currentHand].push(@currentCardNumber() + 1)
    else if play == 'double'
      @hands[@currentHand].push(@currentCardNumber() + 1)
      @currentHand += 1

    button = ".js-#{play}"
    $(button).click()

  currentCardNumber: =>
    maxes = @hands.map((hand) -> Math.max.apply(@, hand))
    Math.max.apply(@, maxes)

  blueMessage: =>
    $('.statuses .status.blue.show').text()

  bet: =>
    $('.value-1 .chip-1:last').click()

    baseBet = Math.max(Math.floor(Number.parseInt($('#points').text(), 10) / 1000), 1)
    multiplier = @bettor.multiplier(@liveShoe())
    betAmount = Math.max(Math.floor(baseBet * multiplier), baseBet)
    for i in [1..betAmount]
      $('.bet-main').click()

    $('.js-deal').click()

  updateShoe: =>
    if @lastMyCards? and @lastDealerCards?
      for card in @lastMyCards.getCards()
        @shoe = @shoe.removeCard(card)
      for card in @lastDealerCards.getCards()
        @shoe = @shoe.removeCard(card)

  remainingCardCount: =>
    Number.parseInt($('.remaining-card-count').text(), 10)

  liveShoe: =>
    shoe = @shoe
    for card in @getMyCards().getCards()
      shoe = shoe.removeCard(card)
    for card in @getDealerCards().getCards()
      shoe = shoe.removeCard(card)
    shoe
