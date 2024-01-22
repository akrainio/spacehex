class_name TileDrawer
extends Node2D

# tile instance
var tile: Tile

# constants defining appearance of hex
const default_fill_color: Color = Color.BLACK
const hover_fill_color: Color = Color.REBECCA_PURPLE
const edge_color: Color = Color(1, 1, 1)
const edge_width: float = 1.5
var edge_len: int = 64

# fill color of tile instance
var fill_color: Color = default_fill_color

# math helpers
var a: float:
	get:
		return 0.5 * edge_len

var b: float:
	get:
		return edge_len * sqrt(3)/2

var _center: Vector2:
	get:
		return Vector2(
			tile.coordinates.x * edge_len * 1.5,
			tile.coordinates.y * b * 2 + tile.coordinates.x%2 * b)

var _right: Vector2:
	get:
		return Vector2(_center.x + edge_len, _center.y)

var _bottom_right: Vector2:
	get:
		return Vector2(_center.x + a, _center.y + b)

var _bottom_left: Vector2:
	get:
		return Vector2(_center.x - a, _center.y + b)

var _left: Vector2:
	get:
		return Vector2(_center.x - edge_len, _center.y)

var _top_left: Vector2:
	get:
		return Vector2(_center.x - a, _center.y - b)

var _top_right: Vector2:
	get:
		return Vector2(_center.x + a, _center.y - b)

func _init(tile_: Tile):
	tile = tile_
	
func get_polygon() -> PackedVector2Array:
	return PackedVector2Array([_right, _top_right, _top_left, _left, _bottom_left, _bottom_right, _right])

func draw_hex() -> void:
	# draw hexagon fill
	draw_colored_polygon(
		get_polygon(),
		fill_color)
	# draw hexagon edge
	draw_polyline_colors(
		get_polygon(),
		PackedColorArray([edge_color, edge_color, edge_color, edge_color, edge_color, edge_color]),
		edge_width, true)

func _draw() -> void:
	var vis_top_left: Vector2 = $"../..".vis_top_left
	var vis_top_right: Vector2 = $"../..".vis_top_right
	var vis_bottom_left: Vector2 = $"../..".vis_bottom_left
	var vis_bottom_right: Vector2 = $"../..".vis_bottom_right
	var vis_left: float = vis_bottom_left.x
	var vis_right: float = vis_bottom_right.x
	var vis_top: float = vis_bottom_left.y
	var vis_bottom: float = vis_top_left.y
	if _right.x > vis_left and _left.x < vis_right and _top_right.y < vis_bottom and _bottom_right.y > vis_top:
		draw_hex()

func _get_coordinates() -> Vector2i:
	return $"..".coordinates

func get_center() -> Vector2:
	return _center

func set_hover_color() -> void:
	fill_color = hover_fill_color
	queue_redraw()

func reset_color() -> void:
	fill_color = default_fill_color
	queue_redraw()

func _input(event):
	if event.is_action_pressed("Zoom In"):
		print("zooming in")
		edge_len -= 16
		queue_redraw()
	elif event.is_action_pressed("Zoom Out"):
		print("zooming out")
		edge_len += 16
		queue_redraw()

#func draw_visible() -> void:
	#var vis_top_left: Vector2 = $"../..".vis_top_left
	#var vis_top_right: Vector2 = $"../..".vis_top_right
	#var vis_bottom_left: Vector2 = $"../..".vis_bottom_left
	#var vis_bottom_right: Vector2 = $"../..".vis_bottom_right
	#var vis_left: float = vis_bottom_left.x
	#var vis_right: float = vis_bottom_right.x
	#var vis_top: float = vis_bottom_left.y
	#var vis_bottom: float = vis_top_left.y
	#if _right.x > vis_left and _left.x < vis_right and _top_right.y < vis_bottom and _bottom_right.y > vis_top:
		##queue_redraw()
