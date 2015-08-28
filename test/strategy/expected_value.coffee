describe 'ExpectedValue', ->
  describe '.expectedValue', ->
    describe 'when I have won', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen().withSeven()
        unseen = new CardList()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(1)

    describe 'when I have lost', ->
      it 'is -1', ->
        myHand = new CardList().withTen().withSeven()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(-1)

    describe 'when a push', ->
      it 'is 0', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(0)

    describe 'when incomplete', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withNine()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(1)

    describe 'when incomplete', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withNine().withAce()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(0)

    describe 'when the dealer draws two', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withThree().withFour()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(1)

    describe 'with blackjack', ->
      it 'is 1.5', ->
        myHand = new CardList().withTen().withAce()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(ExpectedValue.expectedValue(new GameState(myHand, dealer, unseen))).toEqual(1.5)

  describe '.bestPlay', ->
    describe 'when I have blackjack', ->
      it 'is stand', ->
        myHand = new CardList().withAce().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withSeven()
        expect(ExpectedValue.bestPlay(new GameState(myHand, dealer, unseen))).toEqual('stand')

    describe 'when I will hit blackjack', ->
      it 'is double', ->
        myHand = new CardList().withSix().withFive()
        dealer = new CardList().withNine()
        unseen = new CardList().withTen().withTen()
        expect(ExpectedValue.bestPlay(new GameState(myHand, dealer, unseen))).toEqual('double')
