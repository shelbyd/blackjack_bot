subject = null

describe 'Hand', ->
  describe '#value', ->
    describe 'with no cards', ->
      it 'is 0', ->
        cards = new CardList()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(0)

    describe 'with 2,t', ->
      it 'is 12', ->
        cards = new CardList().withTwo().withTen()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(12)

    describe 'with t,t', ->
      it 'is 20', ->
        cards = new CardList().withTen().withTen()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(20)

    describe 'with a,5', ->
      it 'is 16', ->
        cards = new CardList().withAce().withFive()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(16)

    describe 'with a,t,5', ->
      it 'is 16', ->
        cards = new CardList().withAce().withFive().withTen()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(16)

    describe 'with a,9,a', ->
      it 'is 21', ->
        cards = new CardList().withAce().withAce().withNine()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(21)

    describe 'with a,9,a,a', ->
      it 'is 12', ->
        cards = new CardList().withAce().withAce().withAce().withNine()
        hand = new Hand(cards)
        expect(hand.value()).toEqual(12)

  describe '#isSoft', ->
    describe 'with ace,two', ->
      it 'is true', ->
        cards = CardList.fromList(['ace', 'two'])
        hand = new Hand(cards)
        expect(hand.isSoft()).toBe(true)

    describe 'with three, five', ->
      it 'is false', ->
        cards = CardList.fromList(['three', 'five'])
        hand = new Hand(cards)
        expect(hand.isSoft()).toBe(false)

    describe 'with ace,six,six', ->
      it 'is false', ->
        cards = CardList.fromList(['ace', 'six', 'six'])
        hand = new Hand(cards)
        expect(hand.isSoft()).toBe(false)

    describe 'with ace,five,five', ->
      it 'is true', ->
        cards = CardList.fromList(['ace', 'five', 'five'])
        hand = new Hand(cards)
        expect(hand.isSoft()).toBe(true)
