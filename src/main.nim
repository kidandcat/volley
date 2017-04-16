import
  nimgame2 / [
    scene,
  ],
  data


type
  MainScene = ref object of Scene


proc init*(scene: MainScene) =
  init Scene(scene)


proc free*(scene: MainScene) =
  discard


proc newMainScene*(): MainScene =
  new result, free
  init result


method show*(scene: MainScene) =
  echo "Switched to MainScene"

