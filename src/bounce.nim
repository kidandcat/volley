import
  nimgame2 / [
    nimgame,
    settings,
    types,
  ],
  data,
  title,
  main


game = newGame()
if game.init(GameWidth, GameHeight,
             title = GameTitle, icon = GameIcon,
             integerScale = true):
  # Init
  game.setResizable(true)
  game.minSize = (GameWidth, GameHeight)
  game.windowSize = (GameWidth * 2, GameHeight * 2)
  game.centrify()
  # Scenes
  titleScene = newTitleScene()
  mainScene = newMainScene()
  # Run
  game.scene = titleScene
  run game

