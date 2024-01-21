class_name Grid
extends Node2D

@export var width: int = 30
@export var height: int = 15

var tile_scene: PackedScene = preload("res://Tile.tscn")

func _ready() -> void:
	for x: int in range(width):
		for y: int in range(height):
			
			# create tile
			var tile: Tile = tile_scene.instantiate()
			tile.init(self, Vector2i(x, y))
			self.add_child(tile)
			#tile._ready()
			
			# check for center
			if x == width/2 and y == height/2:
				$"Camera2D".global_position = tile.get_center_pos()
