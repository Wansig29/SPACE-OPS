extends Node2D

@export var GreenEnemyScene: PackedScene
@export var YellowEnemyScene: PackedScene
@export var PinkEnemyScene: PackedScene

@export var game_stats: GameStats

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var green_enemy_spawn_timer: Timer = $GreenEnemySpawnTimer
@onready var yellow_enemy_spawn_timer: Timer = $YellowEnemySpawnTimer
@onready var pink_enemy_spawn_timer: Timer = $PinkEnemySpawnTimer

func _ready() -> void:
	green_enemy_spawn_timer.timeout.connect(func():
		handle_spawn(GreenEnemyScene, green_enemy_spawn_timer, 3.0)
	)
	yellow_enemy_spawn_timer.timeout.connect(func():
		handle_spawn(YellowEnemyScene, yellow_enemy_spawn_timer, 5.0)
	)
	pink_enemy_spawn_timer.timeout.connect(func():
		handle_spawn(PinkEnemyScene, pink_enemy_spawn_timer, 10.0)
	)
	
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 50:
			yellow_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
		if new_score > 200:
			pink_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
		)

func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), -16))
	var spawn_rate = time_offset / (0.5 + (game_stats.score * 0.01))
	timer.start(spawn_rate + randf_range(0.25, 0.5))
