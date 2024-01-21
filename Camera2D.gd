extends Camera2D

var is_dragging: bool = true
var mouse_down: bool = false
@onready var grid: Grid = $".."

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			mouse_down = true
		else:
			mouse_down = false
	elif event is InputEventMouseMotion:
		if mouse_down:
			position -= event.relative
