class_name Grid
extends Node2D

const width: int = 30
const height: int = 15

var tile_scene: PackedScene = preload("res://Tile.tscn")

func _ready() -> void:
	for x: int in range(width):
		for y: int in range(height):
			
			# create tile
			var tile: Tile = tile_scene.instantiate()
			tile.init(Vector2i(x, y))
			tile._ready()
			self.add_child(tile)
			
			# check for center
			if x == width/2 and y == height/2:
				$"Camera2D".global_position = tile.get_center_pos()
