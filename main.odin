package main

import rl "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

MARGINS :: 15

PADDLE_WIDTH :: 15
PADDLE_HEIGHT :: 80

Side :: enum { Left, Right }

Paddle :: struct {
	x, y: f32,
	width, height: f32,
	velocity: f32,
	acceleration: f32,
	up_key, down_key: rl.KeyboardKey
}

make_paddle :: proc(side: Side) -> Paddle {
	result := Paddle {
		width        = PADDLE_WIDTH,
		height       = PADDLE_HEIGHT,
		velocity     = 0,
		acceleration = 1,
	}

	switch side {
	case .Left:
		result.x = MARGINS
		result.up_key = rl.KeyboardKey.W
		result.down_key = rl.KeyboardKey.S
	case .Right:
		result.x = SCREEN_WIDTH - MARGINS - result.width
		result.up_key = rl.KeyboardKey.UP
		result.down_key = rl.KeyboardKey.DOWN
	}
	result.y = SCREEN_HEIGHT / 2 - result.height / 2

	return result
}

draw_paddle :: proc(paddle: ^Paddle) {
	rec: rl.Rectangle = {paddle.x, paddle.y, paddle.width, paddle.height}
	rl.DrawRectangleRec(rec, rl.WHITE)
}

move_paddle :: proc(paddle: ^Paddle) {
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
	lower_bound := SCREEN_HEIGHT - paddle.height
	if paddle.y > lower_bound {
		paddle.y = lower_bound
	}
}

main :: proc() {
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Pong")
	defer rl.CloseWindow()
	rl.SetTargetFPS(60)

	paddle_left := make_paddle(Side.Left)
	paddle_right := make_paddle(Side.Right)

	for !rl.WindowShouldClose() {
		move_paddle(&paddle_left)
		move_paddle(&paddle_right)

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawText("PONG", SCREEN_WIDTH / 2 - rl.MeasureText("PONG", 40) / 2, 20, 40, rl.WHITE)
		draw_paddle(&paddle_left)
		draw_paddle(&paddle_right)

		rl.EndDrawing()
	}
}
