package main

import "game"

import rl "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450
MARGINS :: 15

Side :: enum { Left, Right }

main :: proc() {
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Pong")
	defer rl.CloseWindow()
	rl.SetTargetFPS(60)

	game_state := game.init(SCREEN_WIDTH, SCREEN_HEIGHT)
	game.start(&game_state)

	for !rl.WindowShouldClose() {
		game.update(&game_state)

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)

		rl.DrawText("PONG", SCREEN_WIDTH / 2 - rl.MeasureText("PONG", 40) / 2, 20, 40, rl.WHITE)
		game.draw(&game_state)

		rl.EndDrawing()
	}
}
