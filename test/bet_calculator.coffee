describe 'BetCalculator', ->
  describe '.expectedValue', ->
    describe 'with all 10s', ->
      it 'is 0', ->
        shoe = new CardList().withTen().withTen().withTen().withTen().withTen().withTen()

        expect(BetCalculator.expectedValue(shoe)).toEqual(0)
