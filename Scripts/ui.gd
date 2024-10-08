extends CanvasLayer

class_name UI

@onready var lives_label: Label = $MarginContainer/HBoxContainer/LivesLabel
@onready var game_lost_container: CenterContainer = $GameLostContainer

func set_lives(lives: int):
	lives_label.text = "Lives: %d" % lives


func _on_game_lost_button_pressed() -> void:
	get_tree().reload_current_scene()

func game_over():
	game_lost_container.show()
