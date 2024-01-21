class_name Tile
extends StaticBody2D

@onready var grid: Grid = $".."
var coordinates: Vector2i
var edge_color: Color = grid.edge_color
var fill_color: Color = grid.default_fill_color
var center = grid.offset + Vector2(coordinates.x * grid.edge_len * 1.5, coordinates.y * grid.b * 2 + coordinates.x%2 * grid.b)
var right: Vector2
var bottom_right: Vector2
var bottom_left: Vector2
var left: Vector2
var top_left: Vector2
var top_right: Vector2
var hover: bool = false
	
func init(coordinates_: Vector2i) -> void:
	coordinates = coordinates_
	center = grid.offset + Vector2(coordinates.x * grid.edge_len * 1.5, coordinates.y * grid.b * 2 + coordinates.x%2 * grid.b)
	right = Vector2(center.x + grid.edge_len, center.y)
	bottom_right = Vector2(center.x + grid.a, center.y + grid.b)
	bottom_left = Vector2(center.x - grid.a, center.y + grid.b)
	left = Vector2(center.x - grid.edge_len, center.y)
	top_left = Vector2(center.x - grid.a, center.y - grid.b)
	top_right = Vector2(center.x + grid.a, center.y - grid.b)
	
func start_hover() -> void:
	hover = true
	fill_color = grid.hover_fill_color
	queue_redraw()

func end_hover() -> void:
	hover = false
	fill_color = grid.default_fill_color
	queue_redraw()


func _ready() -> void:
	print("tile ready")
	self.connect("mouse_entered", start_hover)
	self.connect("mouse_exited", end_hover)
	$"CollisionPolygon2D".polygon = PackedVector2Array([right, top_right, top_left, left, bottom_left, bottom_right, right])

func draw_hex() -> void:
	draw_colored_polygon(
		PackedVector2Array([right, top_right, top_left, left, bottom_left, bottom_right]),
		fill_color)
	draw_polyline_colors(
		PackedVector2Array([right, top_right, top_left, left, bottom_left, bottom_right, right]),
		PackedColorArray([edge_color, edge_color, edge_color, edge_color, edge_color, edge_color]),
		grid.edge_width, true)

func _draw() -> void:
	draw_hex()
