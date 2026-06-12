package game

import rl "vendor:raylib"

Game :: struct {
	WIDTH, HEIGHT: i32,
	paddle_left, paddle_right: Paddle,
}

Side :: enum { Left, Right }

init :: proc(WIDTH, HEIGHT: i32) -> Game {
	return Game {
		WIDTH = WIDTH,
		HEIGHT = HEIGHT,
		paddle_left = make_paddle(Side.Left, WIDTH),
		paddle_right = make_paddle(Side.Right, WIDTH),
	}
}

start :: proc(game: ^Game) {
	game.paddle_left.y = f32(game.HEIGHT / 2) - game.paddle_right.height / 2
	game.paddle_right.y = f32(game.HEIGHT / 2) - game.paddle_right.height / 2
}

update :: proc(game: ^Game) {
	move_paddle(&game.paddle_left, game)
	move_paddle(&game.paddle_right, game)
}

draw :: proc(game: ^Game) {
	draw_paddle(&game.paddle_left)
	draw_paddle(&game.paddle_right)
}
