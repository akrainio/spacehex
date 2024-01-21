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

		# Print the size of the viewport.
		#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
