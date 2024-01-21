class_name Tile
extends CollisionObject2D

var grid: Grid
var coordinates: Vector2i
var hover: bool = false
var drawer: TileDrawer

func init(grid_: Grid, coordinates_: Vector2i) -> void:
	coordinates = coordinates_
	grid = grid_
	drawer = TileDrawer.new(self)
	self.add_child(drawer)
	
func start_hover() -> void:
	hover = true
	drawer.set_hover_color()

func end_hover() -> void:
	hover = false
	drawer.reset_color()

func _ready() -> void:
	self.mouse_entered.connect(start_hover)
	self.mouse_exited.connect(end_hover)
	$"CollisionPolygon2D".polygon = drawer.get_polygon()

func get_center_pos() -> Vector2:
	return drawer.get_center()
