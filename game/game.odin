package game

import "core:fmt"

import rl "vendor:raylib"

Game :: struct {
	WIDTH, HEIGHT: i32,
	ball: Ball,
	paddle_left, paddle_right: Paddle,
	score_left, score_right: u32
}

Side :: enum { Left, Right }

init :: proc(WIDTH, HEIGHT: i32) -> Game {
	return Game {
		WIDTH = WIDTH,
		HEIGHT = HEIGHT,
		ball = make_ball(),
		paddle_left = make_paddle(Side.Left, WIDTH),
		paddle_right = make_paddle(Side.Right, WIDTH),
		score_left = 0,
		score_right = 0,
	}
}

start :: proc(game: ^Game) {
	reset_paddle(&game.paddle_left)
	game.paddle_left.y = f32(game.HEIGHT / 2) - game.paddle_right.height / 2 + 20

	reset_paddle(&game.paddle_right)
	game.paddle_right.y = f32(game.HEIGHT / 2) - game.paddle_right.height / 2 - 20

	reset_ball(&game.ball)
	game.ball.x = f32(game.WIDTH / 2) - game.ball.width / 2
	game.ball.y = f32(game.HEIGHT / 2) - game.ball.height / 2
	game.ball.last_hit = &game.paddle_left
}

update :: proc(game: ^Game) {
	move_paddle(&game.paddle_left, game)
	move_paddle(&game.paddle_right, game)
	move_ball(&game.ball, game)
}

draw :: proc(game: ^Game) {
	draw_paddle(&game.paddle_left)
	draw_paddle(&game.paddle_right)
	draw_ball(&game.ball)

	buffer: [32]u8
	fmt.bprintf(buffer[:], "%d-%d", game.score_left, game.score_right)
	score_str := cstring(raw_data(buffer[:]))
	rl.DrawText(score_str, game.WIDTH / 2 - rl.MeasureText("0-0", 40) / 2, game.HEIGHT - 60, 40, rl.WHITE)
}
