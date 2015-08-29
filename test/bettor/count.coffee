describe 'Count', ->
  describe '.multiplier', ->
    describe 'with a raw 1-deck shoe', ->
      it 'is 1', ->
        shoe = CardList.shoe(1)
        expect(Count.multiplier(shoe)).toEqual(1)

    describe 'with a raw 6-deck shoe', ->
      it 'is 1', ->
        shoe = CardList.shoe(6)
        expect(Count.multiplier(shoe)).toEqual(1)

    describe 'one deck missing an ace', ->
      it 'is -0.01960', ->
        shoe = CardList.shoe(1).removeCard('ace')
        expect(Count.multiplier(shoe)).toBeCloseTo(-0.01960)

    describe 'six decks missing a two', ->
      it 'is 1.1672', ->
        shoe = CardList.shoe(6).removeCard('two')
        expect(Count.multiplier(shoe)).toBeCloseTo(1.1672)

    describe 'six decks missing a two, three, and six', ->
      it 'is 1.50485', ->
        shoe = CardList.shoe(6).removeCard('two').removeCard('three').removeCard('six')
        expect(Count.multiplier(shoe)).toBeCloseTo(1.50485)
