extends Node2D
class_name Beam

@export var shootSpeed = 1.0
@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@export var beam_wave: PackedScene

var canShoot = true

var beamDirection = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 1.0

func shoot():
		
		var beamWaveNode = beam_wave.instantiate()
		
		beamWaveNode.set_direction(beamDirection)
		
		beamWaveNode.global_position = marker_2d.global_position
		
		beamWaveNode.name = str(randf_range(0,1000))
		
		get_tree().root.add_child(beamWaveNode)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	canShoot = true
	
func setup_direction(direction):
	beamDirection = direction
	
	if direction.x > 0:
		scale.x = 1
		rotation_degrees = 0
	if direction.x < 0:
		scale.x = -1
		rotation_degrees = 0
	if direction.y < 0:
		scale.x = 1
		rotation_degrees = -90
	if direction.y > 0:
		scale.x = 1
		rotation_degrees = 90

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
