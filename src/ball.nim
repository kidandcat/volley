import
  nimgame2 / [
    assets,
    collider,
    entity,
    graphic,
    nimgame,
    types,
    utils,
  ],
  data


const
  speed = 100.0 # Speed (in pixels per second)
  speedInc = 25.0 # Speed increase after each bounce

type
  Ball* = ref object of Entity
    radius: float


proc reset*(ball: Ball) =
  ball.pos = game.size / 2  # place to the center of the screen
  ball.vel.x = speed * randomSign().float
  ball.vel.y = speed * randomSign().float


proc init*(ball: Ball) =
  ball.initEntity()
  ball.graphic = gfxData["ball"]
  ball.radius = ball.graphic.dim.w / 2
  ball.centrify() # Set the center point offset
  ball.reset()

  # Collisions
  ball.tags.add "ball"
  ball.collider = ball.newCircleCollider((0.0, 0.0), ball.radius)
  ball.collider.tags.add "paddle"


proc newBall*(): Ball =
  new result
  result.init()


method update*(ball: Ball, elapsed: float) =
  var movement = ball.vel * elapsed

  ball.pos += movement

  # Top and bottom walls collisions
  if ball.pos.y < ball.radius or
     ball.pos.y >= (game.size.h.float - ball.radius):
    ball.vel.y = -ball.vel.y


method onCollide*(ball: Ball, target: Entity) =
  if "paddle" in target.tags:
    # Check if the ball is in the front of a paddle
    if (ball.pos.y >= target.pos.y - target.center.y) and
       (ball.pos.y <= target.pos.y + target.center.y):

      ball.vel.x = -ball.vel.x  # change horizontal direction

      # Move the ball out of the collision zone
      if ball.pos.x < game.size.w / 2:
        ball.pos.x = target.pos.x + target.center.x + ball.radius + 1
      else:
        ball.pos.x = target.pos.x - target.center.x - ball.radius - 1

      # increase speed
      ball.vel += (speedInc, speedInc) * ball.vel / abs(ball.vel)

