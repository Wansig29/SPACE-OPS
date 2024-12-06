extends Node2D

@export var game_stats: GameStats
@onready var ship: Node2D = $Ship
@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	randomize()
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)
	ship.tree_exiting.connect(_on_ship_exiting)

func update_score_label(new: int) -> void:
	score_label.text = "Score: " + str(new)


func _on_ship_exiting() -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Menu/game_over.tscn")
