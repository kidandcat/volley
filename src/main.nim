import
  nimgame2 / [
    scene,
  ],
  data,
  paddle


type
  MainScene = ref object of Scene
    leftPaddle, rightPaddle: Paddle


proc init*(scene: MainScene) =
  init Scene(scene)

  # left paddle
  scene.leftPaddle = newPaddle(ppLeft, pcPlayer1)
  scene.add scene.leftPaddle

  # right paddle
  scene.rightPaddle = newPaddle(ppRight, pcPlayer2)
  scene.add scene.rightPaddle


proc free*(scene: MainScene) =
  discard


proc newMainScene*(): MainScene =
  new result, free
  init result


method show*(scene: MainScene) =
  echo "Switched to MainScene"

