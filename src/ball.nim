import
  nimgame2 / [
    assets,
    audio,
    draw,
    entity,
    graphic,
    nimgame,
    types,
    utils,
  ],
  data


const
  Speed = 300.0 # Speed (in pixels per second)
  Pause = 1.0 # Pause value before launch (in seconds)

type
  Ball* = ref object of Entity
    radius: float
    pause: float


proc reset*(ball: Ball) =
  ball.pos = (game.size.w / 2, 50.0)  # place to the center of the screen
  ball.vel.x = Speed * randomSign().float
  ball.vel.y = -200
  ball.pause = Pause


proc init*(ball: Ball) =
  ball.initEntity()
  ball.graphic = gfxData["ball"]
  ball.radius = ball.graphic.dim.w / 2
  ball.centrify() # Set the center point offset
  ball.reset()

  # Collisions
  ball.tags.add "ball"
  ball.collider = ball.newCircleCollider((0.0, 0.0), ball.radius)

  # physics
  ball.acc.y = 200
  ball.drg.x = 10
  ball.physics = platformerPhysics


proc newBall*(): Ball =
  new result
  result.init()


method render*(ball: Ball) =
  ball.renderEntity()
  if ball.pause > 0.0: # pre-launch pause
    discard circle(ball.pos, ball.pause * 100, 0xFFFFFFFF'u32, DrawMode.aa)


method update*(ball: Ball, elapsed: float) =
  if ball.pause <= 0.0:
    ball.updateEntity elapsed

    if ball.vel.x > Speed:
      ball.vel.x = Speed
    if ball.vel.x < -Speed:
      ball.vel.x = -Speed
    if ball.vel.y > Speed:
      ball.vel.y = Speed
    if ball.vel.y < -Speed:
      ball.vel.y = -Speed

    # Top and walls collisions
    if ball.pos.y < ball.radius:
      ball.vel.y = -ball.vel.y

    if ball.pos.x < ball.radius or ball.pos.x >= (game.size.w.float - ball.radius):
      ball.vel.x = -ball.vel.x

  else: # pre-launch pause
    ball.pause -= elapsed


method onCollide*(ball: Ball, target: Entity) =
  if "paddle" in target.tags:
    ball.pos.y = target.pos.y - target.center.y - ball.radius - 1
    ball.vel.y = -ball.vel.y
    if ball.vel.y > 0:
      ball.vel.y += 50
    else:
      ball.vel.y -= 50
    return
  if "sides" in target.tags or "stick" in target.tags:
    ball.vel.x = -ball.vel.x
    if ball.vel.x > 0:
      ball.vel.x += 50
    else:
      ball.vel.x -= 50
