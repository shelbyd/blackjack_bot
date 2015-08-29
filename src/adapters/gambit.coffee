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
    setInterval((=> @loop()), 1000)

  loop: =>
    myCards = @getMyCards()
    dealerCards = @getDealerCards()
    return unless myCards.cardCount() and dealerCards.cardCount()
    @rejectInsurance()
    gameState = new GameState(myCards, dealerCards, CardList.shoe(6))
    play = @strategy.bestPlay(gameState)
    button = ".js-#{play}"
    $(button).click()

  getMyCards: => @getCards [21, 22, 23, 24, 25, 26, 27]

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

  getDealerCards: => @getCards [1, 2, 3, 4, 5, 6, 7]

  rejectInsurance: =>
    insuranceMessage = $('.statuses .status.blue.show')
    if insuranceMessage.length and insuranceMessage.text() == 'Do You Want Insurance?'
      $('.js-reject-insurance').click()
