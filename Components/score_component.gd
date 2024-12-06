# Give the component a class name so it can be instanced as a custom node
class_name ScoreComponent
extends Node

@export var game_stats: GameStats
@export var adjust_amount = 5

func adjust_score(amount: int = adjust_amount):
	game_stats.score += amount
