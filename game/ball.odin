package game

import "core:math"

import rl "vendor:raylib"

Ball :: struct {
	x, y: f32,
	width, height: f32,
	speed: f32,
	direction: f32,
	rec: rl.Rectangle,
}

make_ball :: proc() -> Ball {
	result := Ball {
		x = 0,
		y = 0,
		width = 10,
		height = 10,
		speed = 5,
		direction = 0,
	}
	return result
}

draw_ball :: proc(ball: ^Ball) {
	rl.DrawRectangleRec(ball.rec, rl.WHITE)
}

move_ball :: proc(ball: ^Ball, game: ^Game) {
	ball.x += ball.speed * math.cos(ball.direction)
	ball.y += ball.speed * math.sin(ball.direction)

	if rl.CheckCollisionRecs(ball.rec, game.paddle_left.rec) {
		ball.direction = 0
	}
	if rl.CheckCollisionRecs(ball.rec, game.paddle_right.rec) {
		ball.direction = math.PI
	}

	ball.rec = {ball.x, ball.y, ball.width, ball.height}
}
