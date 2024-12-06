extends Control

const SAVE_PATH = "user://save.cfg"

@export var game_stats: GameStats
@onready var score_value: Label = $ScoreValue
@onready var high_score_value: Label = $HighScoreValue

func _ready() -> void:
	if !score_value or !high_score_value:
		print("ScoreValue or HighScoreValue nodes are missing in the scene.")
		return
	
	load_highscore()

	score_value.text = str(game_stats.score)
	high_score_value.text = str(game_stats.highscore)

	game_stats.score_changed.connect(_on_score_changed)
	game_stats.highscore_changed.connect(_on_highscore_changed)

func _on_score_changed(new_score) -> void:
	score_value.text = str(new_score)
	if new_score > game_stats.highscore:
		game_stats.highscore = new_score
		game_stats.highscore_changed.emit(new_score)
		save_highscore()

func _on_highscore_changed(new_highscore) -> void:
	high_score_value.text = str(new_highscore)

func load_highscore():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		game_stats.highscore = config.get_value("game", "highscore", 0)

func save_highscore() -> void:
	var config = ConfigFile.new()
	config.set_value("game", "highscore", game_stats.highscore)
	config.save(SAVE_PATH)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		game_stats.score = 0
		get_tree().change_scene_to_file("res://main.tscn")
