class_name Grid
extends Node2D


const offset: Vector2 = Vector2(edge_len, b)

const width: int = 30
const height: int = 15
const edge_len: int = 64
const a: float = 0.5 * edge_len
const b: float = edge_len * sqrt(3)/2
const default_fill_color: Color = Color.BLACK
const hover_fill_color: Color = Color.REBECCA_PURPLE

const edge_width: float = 1.5
const edge_color: Color = Color(1, 1, 1)
var tiles: Array[Tile] = []
var tile_scene: PackedScene = preload("res://Tile.tscn")
var center_tile: Tile


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("grid ready")
	for x: int in range(width):
		for y: int in range(height):
			
			# create tile
			var tile: Tile = tile_scene.instantiate()
			tile.init(Vector2i(x, y))
			tile._ready()
			tiles.append(tile)
			self.add_child(tile)
			
			# check for center
			if x == width/2 and y == height/2:
				center_tile = tile
				$"Camera2D".global_position = tile.center
