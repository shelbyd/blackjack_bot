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
