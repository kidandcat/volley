import
  nimgame2 / [
    assets,
    collider,
    entity,
    graphic,
    nimgame,
    types,
  ],
  data


const
  speed = 300.0 # Speed (in pixels per second)
  speedInc = 25.0 # Speed increase after each bounce

type
  Ball* = ref object of Entity


proc reset*(ball: Ball) =
  ball.pos = game.size / 2


proc init*(ball: Ball) =
  ball.initEntity()
  ball.graphic = gfxData["ball"]
  ball.centrify() # Set the center point offset
  ball.reset()

  # Collisions
  ball.tags.add "ball"
  ball.collider = ball.newCircleCollider((0.0, 0.0), ball.graphic.dim.w / 2)


proc newBall*(): Ball =
  new result
  result.init()


method update*(ball: Ball, elapsed: float) =
  var movement = speed * elapsed

