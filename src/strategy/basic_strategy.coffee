class BasicStrategy
  ORDER = ['two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'ace']

  h = -> 'hit'
  s = -> 'stand'
  dh = (gameState) -> if gameState.doubleAllowed() then 'double' else 'hit'
  rh = -> 'hit'
  rs = -> 'stand'
  ds = (gameState) -> if gameState.doubleAllowed() then 'double' else 'stand'
  ph = -> 'split'
  p = -> 'split'
  rp = -> 'split'

  STRATEGY =
    #     2   3   4   5s  6   7   8s   s 10   A
    4:  [ h,  h,  h,  h,  h,  h,  h,  h,  h,  h]
    5:  [ h,  h,  h,  h,  h,  h,  h,  h,  h,  h]
    6:  [ h,  h,  h,  h,  h,  h,  h,  h,  h,  h]
    7:  [ h,  h,  h,  h,  h,  h,  h,  h,  h,  h]
    8:  [ h,  h,  h,  h,  h,  h,  h,  h,  h,  h]
    9:  [ h, dh, dh, dh, dh,  h,  h,  h,  h,  h]
    10: [dh, dh, dh, dh, dh, dh, dh, dh,  h,  h]
    11: [dh, dh, dh, dh, dh, dh, dh, dh, dh, dh]
    12: [ h,  h,  s,  s,  s,  h,  h,  h,  h,  h]
    13: [ s,  s,  s,  s,  s,  h,  h,  h,  h,  h]
    14: [ s,  s,  s,  s,  s,  h,  h,  h,  h,  h]
    15: [ s,  s,  s,  s,  s,  h,  h,  h, rh, rh]
    16: [ s,  s,  s,  s,  s,  h,  h, rh, rh, rh]
    17: [ s,  s,  s,  s,  s,  s,  s,  s,  s, rs]
    18: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]
    19: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]
    20: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]
    21: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]

  SOFT_STRATEGY =
    #     2   3   4   5   6   7   8   9  10   A
    13: [ h,  h,  h, dh, dh,  h,  h,  h,  h,  h]
    14: [ h,  h,  h, dh, dh,  h,  h,  h,  h,  h]
    15: [ h,  h, dh, dh, dh,  h,  h,  h,  h,  h]
    16: [ h,  h, dh, dh, dh,  h,  h,  h,  h,  h]
    17: [ h, dh, dh, dh, dh,  h,  h,  h,  h,  h]
    18: [ds, ds, ds, ds, ds,  s,  s,  h,  h,  h]
    19: [ s,  s,  s,  s, ds,  s,  s,  s,  s,  s]
    20: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]
    21: [ s,  s,  s,  s,  s,  s,  s,  s,  s,  s]

  SPLIT_STRATEGY =
    #        2   3   4   5   6   7   8   9  10   A
    two:   [ph, ph,  p,  p,  p,  p,  h,  h,  h,  h]
    three: [ph, ph,  p,  p,  p,  p,  h,  h,  h,  h]
    four:  [ h,  h,  h, ph, ph,  h,  h,  h,  h,  h]
    five:  STRATEGY[10]
    six:   [ph,  p,  p,  p,  p,  h,  h,  h,  h,  h]
    seven: [ p,  p,  p,  p,  p,  p,  h,  h,  h,  h]
    eight: [ p,  p,  p,  p,  p,  p,  p,  p,  p, rp]
    nine:  [ p,  p,  p,  p,  p,  s,  p,  p,  s,  s]
    ten:   STRATEGY[20]
    ace:   [ p,  p,  p,  p,  p,  p,  p,  p,  p,  p]

  @bestPlay: (gameState) ->
    return 'stand' if gameState.myHand().bust()
    handValue = gameState.myHand().value()
    dealerCard = gameState.dealer.getCards()[0]
    isSoft = gameState.myHand().isSoft()
    canSplit = gameState.splitAllowed()
    strategy =
      if canSplit
        SPLIT_STRATEGY[gameState.my.getCards()[0]]
      else if isSoft
        SOFT_STRATEGY[handValue]
      else
        STRATEGY[handValue]

    strategy[ORDER.indexOf(dealerCard)](gameState)
