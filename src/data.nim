import
  nimgame2 / [
    assets,
    font,
    scene,
    truetypefont,
    types,
  ]


const
  GameWidth* = 640
  GameHeight* = 360
  GameTitle* = "Nimgame 2 Bounce"


var
  titleScene*, mainScene*: Scene


var
  defaultFont*, bigFont*: TrueTypeFont


proc loadData*() =
  defaultFont = newTrueTypeFont()
  if not defaultFont.load("data/fnt/FSEX300.ttf", 16):
    echo "ERROR: Can't load font"
  bigFont = newTrueTypeFont()
  if not bigFont.load("data/fnt/FSEX300.ttf", 32):
    echo "ERROR: Can't load font"


proc freeData*() =
  defaultFont.free()
  bigFont.free()

