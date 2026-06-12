package game

import rl "vendor:raylib"

Paddle :: struct {
	x, y: f32,
	width, height: f32,
	velocity: f32,
	acceleration: f32,
	up_key, down_key: rl.KeyboardKey
}

make_paddle :: proc(side: Side, WIDTH: i32) -> Paddle {
	result := Paddle {
		width        = 15,
		height       = 80,
		velocity     = 0,
		acceleration = 1,
	}

	MARGINS :: 15

	switch side {
	case .Left:
		result.x = MARGINS
		result.up_key = rl.KeyboardKey.W
		result.down_key = rl.KeyboardKey.S
	case .Right:
		result.x = f32(WIDTH) - MARGINS - result.width
		result.up_key = rl.KeyboardKey.UP
		result.down_key = rl.KeyboardKey.DOWN
	}

	return result
}

draw_paddle :: proc(paddle: ^Paddle) {
	rec: rl.Rectangle = {paddle.x, paddle.y, paddle.width, paddle.height}
	rl.DrawRectangleRec(rec, rl.WHITE)
}

move_paddle :: proc(paddle: ^Paddle, game: ^Game) {
	if rl.IsKeyDown(paddle.up_key) {
		paddle.velocity -= paddle.acceleration
	}
	if rl.IsKeyDown(paddle.down_key) {
		paddle.velocity += paddle.acceleration
	}
	paddle.y += paddle.velocity
	paddle.velocity *= 0.8

	if paddle.y < 0 {
		paddle.y = 0
	}
	lower_bound := f32(game.HEIGHT) - paddle.height
	if paddle.y > lower_bound {
		paddle.y = lower_bound
	}
}
