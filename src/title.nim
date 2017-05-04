import
  nimgame2 / [
    entity,
    font,
    nimgame,
    scene,
    textgraphic,
    types,
  ],
  data


type
  TitleScene = ref object of Scene


proc init*(scene: TitleScene) =
  init Scene(scene)

  # Create a title text graphic with a big font
  let titleText = newTextGraphic(bigFont)
  titleText.setText GameTitle # Set the text to render

  let title = newEntity() # Create a title entity
  title.graphic = titleText # Assign the title text graphic
  title.centrify() # Set the origin point to the graphic's center
  title.pos = (GameWidth / 2, GameHeight / 3) # Set the title position on the screen
  scene.add title # Add title entity to the scene

  # Create a subtitle text graphic with a default font
  let subtitleText = newTextGraphic(defaultFont)
  subtitleText.setText "Press any key to start" # Set the text

  let subtitle = newEntity() # Create a subtitle entity
  subtitle.graphic = subtitleText # Assign the subtitle text graphic
  subtitle.centrify() # Set the origin point to the graphic's center
  subtitle.pos = game.size / 2 # Place to the center of the screen
  scene.add subtitle # Add subtitle entity to the scene


proc free*(scene: TitleScene) =
  discard


proc newTitleScene*(): TitleScene =
  new result, free
  init result


method event*(scene: TitleScene, event: Event) =
  if event.kind == KeyDown:
    game.scene = mainScene

