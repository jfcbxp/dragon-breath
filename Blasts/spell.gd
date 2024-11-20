extends CharacterBody2D

class_name Spell

@export var SPEED = 100

var direction: float
var spawnPosition: Vector2
var spawnRotation: float

func _ready() -> void:
	global_position = spawnPosition
	global_rotation_degrees = spawnRotation
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(0, -SPEED).rotated(PI/2.0 * direction)
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
