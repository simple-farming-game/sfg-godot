extends CharacterBody2D

@export var speed = 300
@onready var tile_map = $"../TileMap"

func calculate_direction_vector(point_a: Vector2, point_b: Vector2) -> Vector2:
	var ab_vector = point_b - point_a
	var ab_normalized = ab_vector.normalized()
	var ab_round = ab_normalized.snapped(Vector2(1,1))
	return ab_round


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	print(input_direction)
	if Input.is_action_pressed("speed"):
		speed = 400
	else:
		speed = 300

func _physics_process(delta):
	get_input()
	move_and_slide()

func _process(delta):
	if Input.is_action_pressed("use"):
		var map_pos = tile_map.local_to_map(position)
		var mouse_pos_tile = tile_map.local_to_map(get_global_mouse_position())
		var source_id = tile_map.get_cell_source_id(0, position/32-floor(position/32))
		var atlas_coords = Vector2(1,0)
		var alternative = tile_map.get_cell_alternative_tile(0, position/32-floor(position/32)) 
		tile_map.set_cell(
			0,
			Vector2(map_pos[0],map_pos[1])+calculate_direction_vector(map_pos, Vector2(mouse_pos_tile[0],mouse_pos_tile[1])),
			source_id,
			atlas_coords,
			alternative
		)
		print(map_pos)
		print(calculate_direction_vector(map_pos, Vector2(mouse_pos_tile[0],mouse_pos_tile[1])))
	
