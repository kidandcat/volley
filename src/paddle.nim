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
  GravAcc* = 800
  Drag* = 2000
  JumpVel = 550
  MaxVel = 350


type
  PaddlePlacement* = enum
    ppLeft, ppRight

  PaddleControl* = enum
    pcPlayer1, pcPlayer2

  Paddle* = ref object of Entity
    control*: PaddleControl
    box*: Entity


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
  paddle.collider = paddle.newBoxCollider((0.0, 0.0), (paddle.graphic.w+2, paddle.graphic.h-4))
  paddle.collider.tags.add "ball"
  paddle.collider.tags.add "stick"

  let box = newEntity()
  box.initEntity()
  box.centrify()
  box.pos = paddle.pos
  box.parent = paddle
  box.tags.add "sides"
  box.collider = paddle.newBoxCollider((0.0, 0.0), (paddle.graphic.w-4, paddle.graphic.h+2))
  box.collider.tags.add "ball"
  paddle.box = box
  

  # physics
  paddle.acc.y = GravAcc
  paddle.drg.x = Drag
  paddle.physics = platformerPhysics


proc newPaddle*(placement: PaddlePlacement, control: PaddleControl): Paddle =
  new result
  result.init(placement, control)


method update*(paddle: Paddle, elapsed: float) =
  paddle.updateEntity elapsed
  # Read input
  case paddle.control:
  # First player
  of pcPlayer1:
    if ScancodeW.pressed and paddle.pos.y > game.size.h.float - paddle.center.y: paddle.vel.y = -JumpVel
    if ScancodeA.down: paddle.vel.x = -MaxVel
    if ScancodeD.down: paddle.vel.x = MaxVel
  # Second player
  of pcPlayer2:
    if ScancodeUp.pressed and paddle.pos.y > game.size.h.float - paddle.center.y: paddle.vel.y = -JumpVel
    if ScancodeLeft.down: paddle.vel.x = -MaxVel
    if ScancodeRight.down: paddle.vel.x = MaxVel

  # Check for the screen borders
  paddle.pos.y = clamp(
    paddle.pos.y,
    paddle.center.y,
    game.size.h.float - paddle.center.y)
  paddle.pos.x = clamp(
    paddle.pos.x,
    paddle.center.x,
    game.size.w.float - paddle.center.x)



