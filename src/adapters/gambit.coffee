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
    setInterval((=> @loop()), 1000)

  loop: =>
    if @remainingCardCount() == 312
      console.log 'Reshuffle!!!'
      @shoe = CardList.shoe(6)

    if @blueMessage() == 'Place Your Bet'
      @donePlaying = false
      @updateShoe()
      @bet()
    else if @haveCards()
      @play()

  haveCards: =>
    @getMyCards().cardCount() and @getDealerCards().cardCount()

  getMyCards: =>
    @lastMyCards = @getCards [21, 22, 23, 24, 25, 26, 27]
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
      if @donePlaying
        @getCards [1, 2, 3, 4, 5, 6, 7, 99999]
      else
        @getCards [1, 2, 3, 4, 5, 6, 7]
    @lastDealerCards

  play: =>
    @rejectInsurance()
    gameState = new GameState(@getMyCards(), @getDealerCards(), @liveShoe())
    play = @strategy.bestPlay(gameState)
    @donePlaying = play == 'stand'
    button = ".js-#{play}"
    $(button).click()

  rejectInsurance: =>
    if @blueMessage() == 'Do You Want Insurance?'
      $('.js-reject-insurance').click()

  blueMessage: =>
    $('.statuses .status.blue.show').text()

  bet: =>
    $('.value-1 .chip-1:last').click()

    baseBet = 2
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
