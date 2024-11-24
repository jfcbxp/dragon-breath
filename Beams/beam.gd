extends Node2D
class_name Beam

@export var shootSpeed = 1.0
@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@export var beam_wave: PackedScene

var canShoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 0.1

func shoot(beamDirection: Vector2):
		
		if canShoot:
			canShoot = false
			timer.start()
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


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
