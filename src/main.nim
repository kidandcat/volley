import
  nimgame2 / [
    input,
    scene,
    settings,
  ],
  ball,
  data,
  paddle


type
  MainScene = ref object of Scene
    leftPaddle, rightPaddle: Paddle
    ball: Ball


proc init*(scene: MainScene) =
  init Scene(scene)

  # left paddle
  scene.leftPaddle = newPaddle(ppLeft, pcPlayer1)
  scene.add scene.leftPaddle

  # right paddle
  scene.rightPaddle = newPaddle(ppRight, pcPlayer2)
  scene.add scene.rightPaddle

  # ball
  scene.ball = newBall()
  scene.add scene.ball


proc free*(scene: MainScene) =
  discard


proc newMainScene*(): MainScene =
  new result, free
  init result


method show*(scene: MainScene) =
  echo "Switched to MainScene"
  scene.ball.reset()


method update*(scene: MainScene, elapsed: float) =
  scene.updateScene(elapsed)

  if ScancodeF10.pressed: colliderOutline = not colliderOutline
  if ScancodeF11.pressed: showInfo = not showInfo

