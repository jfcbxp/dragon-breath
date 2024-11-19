# A gun that casts a LaserBeam2D. Deals damage per second on the laser's
# collider.

class_name LaserGun
extends Node2D

@export var damage_per_second := 200.0

@onready var laser_beam := $LaserBeam2D
@onready var shooter := owner

var is_firing := false: set = set_is_firing
var collision_mask := 0: set = set_collision_mask


func _ready() -> void:
	set_physics_process(false)
	laser_beam.add_exception(owner)


func set_is_firing(firing: bool) -> void:
	laser_beam.is_casting = is_firing
	is_firing = firing
	set_physics_process(is_firing)



func set_collision_mask(new_mask: int) -> void:
	collision_mask = new_mask
	laser_beam.collision_mask = collision_mask
