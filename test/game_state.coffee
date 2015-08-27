describe 'GameState', ->
  describe '#won/#lost/#push', ->
    it 'when I have lost', ->
      myHand = new CardList().withTen().withSeven()
      dealer = new CardList().withTen().withTen()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(true)
      expect(gameState.push()).toEqual(false)

    it 'when I have won', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen().withSeven()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(true)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'when the dealer has one card', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(false)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'when the dealer has 16', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen().withSix()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(false)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'when the dealer has 17', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen().withSeven()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(true)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'when the dealer busts', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen().withSix().withSeven()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(true)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'when I bust', ->
      myHand = new CardList().withTen().withTen().withTwo()
      dealer = new CardList().withTen().withSix()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(false)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(true)
      expect(gameState.push()).toEqual(false)

    it 'when a push', ->
      myHand = new CardList().withTen().withTen()
      dealer = new CardList().withTen().withTen()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(true)

    it 'an incomplete push', ->
      myHand = new CardList().withTen().withSix()
      dealer = new CardList().withTen().withSix()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(false)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(false)
      expect(gameState.push()).toEqual(false)

    it 'both bust the same', ->
      myHand = new CardList().withTen().withSix().withSix()
      dealer = new CardList().withTen().withSix().withSix()
      unseen = new CardList()
      gameState = new GameState(myHand, dealer, unseen)
      expect(gameState.over()).toEqual(true)
      expect(gameState.won()).toEqual(false)
      expect(gameState.lost()).toEqual(true)
      expect(gameState.push()).toEqual(false)

  describe '#expectedValue', ->
    describe 'when I have won', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen().withSeven()
        unseen = new CardList()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(1)

    describe 'when I have lost', ->
      it 'is -1', ->
        myHand = new CardList().withTen().withSeven()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(-1)

    describe 'when a push', ->
      it 'is 0', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(0)

    describe 'when incomplete', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withNine()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(1)

    describe 'when incomplete', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withNine().withAce()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(0)

    describe 'when the dealer draws two', ->
      it 'is 1', ->
        myHand = new CardList().withTen().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withThree().withFour()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(1)

    describe 'with blackjack', ->
      it 'is 1.5', ->
        myHand = new CardList().withTen().withAce()
        dealer = new CardList().withTen().withTen()
        unseen = new CardList()
        expect(new GameState(myHand, dealer, unseen).expectedValue()).toEqual(1.5)

  describe '#bestPlay', ->
    describe 'when I have blackjack', ->
      it 'is stand', ->
        myHand = new CardList().withAce().withTen()
        dealer = new CardList().withTen()
        unseen = new CardList().withSeven()
        expect(new GameState(myHand, dealer, unseen).bestPlay()).toEqual('stand')

    describe 'when I will hit blackjack', ->
      it 'is double', ->
        myHand = new CardList().withSix().withFive()
        dealer = new CardList().withNine()
        unseen = new CardList().withTen().withTen()
        expect(new GameState(myHand, dealer, unseen).bestPlay()).toEqual('double')
