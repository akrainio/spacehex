class_name Grid
extends Node2D

@export var width: int = 30
@export var height: int = 15

var tile_scene: PackedScene = preload("res://Tile.tscn")
@onready var camera: Camera2D = $"Camera2D"
var visibile_area: Rect2
var vis_top_left: Vector2
var vis_top_right: Vector2
var vis_bottom_left: Vector2
var vis_bottom_right: Vector2

func _ready() -> void:
	for x: int in range(width):
		for y: int in range(height):
			
			# create tile
			var tile: Tile = tile_scene.instantiate()
			tile.init(self, Vector2i(x, y))
			self.add_child(tile)
			
			# check for center
			if x == width/2 and y == height/2:
				camera.global_position = tile.get_center_pos()

func _process(delta):
	visibile_area = Rect2($"Camera2D".get_screen_center_position() - get_viewport_rect().size / 2, get_viewport_rect().size)
	vis_top_left = visibile_area.position
	vis_top_right = visibile_area.position + Vector2(visibile_area.size.x, 0)
	vis_bottom_left = visibile_area.position + Vector2(0, visibile_area.size.y)
	vis_bottom_right = visibile_area.position + Vector2(visibile_area.size.x, visibile_area.size.y)
