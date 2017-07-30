import
  nimgame2 / [
    assets,
    graphic,
    input,
    nimgame,
    entity,
  ],
  data


const
  Speed = 250.0 # Speed (in pixels per second)


type
  PaddlePlacement* = enum
    ppLeft, ppRight

  PaddleControl* = enum
    pcPlayer1, pcPlayer2

  Paddle* = ref object of Entity
    control*: PaddleControl


proc init*(paddle: Paddle, placement: PaddlePlacement, control: PaddleControl) =
  paddle.initEntity()
  paddle.graphic = gfxData["paddle"]
  paddle.centrify() # Set the center point offset

  # Set position
  paddle.pos = case placement:
    of ppLeft: (paddle.graphic.w.float, game.size.h / 2)
    of ppRight: (float(game.size.w - paddle.graphic.w), game.size.h / 2)

  paddle.control = control # Set control mode

  # Collisions
  paddle.tags.add "paddle"
  paddle.collider = paddle.newBoxCollider((0.0, 0.0), paddle.graphic.dim)
  paddle.collider.tags.add "ball"


proc newPaddle*(placement: PaddlePlacement, control: PaddleControl): Paddle =
  new result
  result.init(placement, control)


method update*(paddle: Paddle, elapsed: float) =
  var movement = Speed * elapsed

  # Read input
  case paddle.control:
  # First player
  of pcPlayer1:
    if ScancodeQ.down: paddle.pos.y -= movement # Move up
    if ScancodeA.down: paddle.pos.y += movement # Move down
  # Second player
  of pcPlayer2:
    if ScancodeUp.down: paddle.pos.y -= movement    # Move up
    if ScancodeDown.down: paddle.pos.y += movement  # Move down

  # Check for the screen borders
  paddle.pos.y = clamp(
    paddle.pos.y,
    paddle.center.y,
    game.size.h.float - paddle.center.y)



