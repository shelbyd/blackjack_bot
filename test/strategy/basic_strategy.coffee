describe 'BasicStrategy', ->
  ace = 'ace'
  two = 'two'
  three = 'three'
  four = 'four'
  five = 'five'
  six = 'six'
  seven = 'seven'
  eight = 'eight'
  nine = 'nine'
  ten = 'ten'

  describe '.bestPlay', ->
    gameState = (hand, dealer) -> new GameState(hand, dealer, CardList.shoe(1))

    tests = [
      [[two, three], eight, 'hit']
      [[four, five], six, 'double']
      [[four, three, two], six, 'hit']
      [[six, four], six, 'double']
      [[six, two, two], six, 'hit']
      [[five, seven], six, 'stand']
      [[five, ten], ten, 'hit']
      [[seven, ten], ace, 'stand']
      [[ace, two], five, 'double']
      [[ace, seven], four, 'double']
      [[ace, four, three], four, 'stand']
      [[two, two], two, 'split']
      [[two, two], four, 'split']
      [[eight, eight], ace, 'split']
    ]

    for test in tests
      ((test) ->
        describe "I have #{test[0].join(',')} dealer has #{test[1]}", ->
          it "is #{test[2]}", ->
            hand = CardList.fromList(test[0])
            dealer = CardList.fromList([test[1]])
            expect(BasicStrategy.bestPlay(gameState(hand, dealer))).toEqual(test[2])
      )(test)
