package game

import "core:math"

import rl "vendor:raylib"

Ball :: struct {
	x, y: f32,
	width, height: f32,
	x_vel, y_vel: f32,
	speed: f32,
	rec: rl.Rectangle,
	last_hit: ^Paddle,
}

make_ball :: proc() -> Ball {
	result := Ball {
		x = 0,
		y = 0,
		width = 10,
		height = 10,
		x_vel = 1,
		y_vel = 0,
		speed = 5,
	}
	return result
}

reset_ball :: proc(ball: ^Ball) {
	ball.x = 0
	ball.y = 0
	ball.x_vel = 1
	ball.y_vel = 0
	ball.speed = 5
}

draw_ball :: proc(ball: ^Ball) {
	rl.DrawRectangleRec(ball.rec, rl.WHITE)
}

move_ball :: proc(ball: ^Ball, game: ^Game) {
	bounce_angle: f32

	if ball.last_hit != &game.paddle_left && rl.CheckCollisionRecs(ball.rec, game.paddle_left.rec) {
		difference := (game.paddle_left.y + game.paddle_left.height / 2) - (ball.y + ball.height / 2)
		bounce_angle = difference / (game.paddle_left.y / 2) * math.PI / 4
		ball.last_hit = &game.paddle_left
		ball.x_vel = math.cos(bounce_angle)
		ball.y_vel = -math.sin(bounce_angle)
		ball.speed += 0.4

	}
	if ball.last_hit != &game.paddle_right && rl.CheckCollisionRecs(ball.rec, game.paddle_right.rec) {
		difference := (game.paddle_right.y + game.paddle_right.height / 2) - (ball.y + ball.height / 2)
		bounce_angle = difference / (game.paddle_right.y / 2) * math.PI / 3
		ball.last_hit = &game.paddle_right
		ball.x_vel = -math.cos(bounce_angle)
		ball.y_vel = -math.sin(bounce_angle)
		ball.speed += 0.4
	}

	if ball.y - ball.height < 0 || ball.y + ball.height > f32(game.HEIGHT) {
		ball.y_vel *= -1
	}

	if ball.x - ball.width < 0 {
		game.score_right += 1
		start(game)
	}
	if ball.x + ball.width > f32(game.WIDTH) {
		game.score_left += 1
		start(game)
	}

	ball.x += ball.x_vel * ball.speed
	ball.y += ball.y_vel * ball.speed

	ball.rec = {ball.x, ball.y, ball.width, ball.height}
}
