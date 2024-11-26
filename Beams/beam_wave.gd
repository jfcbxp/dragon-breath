extends Area2D

class_name BeamWave

@export var speed = 200
@export var damage = 15

var direction: Vector2

func _ready() -> void:
	add_to_group("Beam")
	await get_tree().create_timer(10).timeout
	queue_free()

func set_direction(beamWaveDirection):
	direction = beamWaveDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Beam"):
		queue_free()
