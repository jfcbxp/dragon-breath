extends CharacterBody2D
class_name BaseCharacter

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var _move_speed_fly: float = 228.0

@export_category("Objects")
@export var _animation_player: AnimationPlayer
@export var _sprite2D: Sprite2D
@export var attack_area_collision: CollisionShape2D
@export var _hair: Sprite2D
@export var fly_timer: Timer

var _can_attack: bool = true
var _attack_animation_name: String 
var last_velocity: Vector2
var fly: bool
var can_fly: bool = true

func _physics_process(delta: float) -> void:
	_move(delta)
	_animate()


func _move(delta: float) -> void:
		var _direction: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		
		if Input.is_key_pressed(KEY_SPACE) && can_fly:
			fly = !fly
			can_fly = false
			fly_timer.start()
			
		if fly:
			velocity = _direction * _move_speed_fly
		else:
			velocity = _direction * _move_speed
			
		
		update_collision_layer_mask()

		move_and_collide(velocity * delta)
	

		
func _animate() -> void:
	if velocity.x > 0:
		attack_area_collision.position.x = 32
		
	if velocity.x < 0:
		attack_area_collision.position.x = -32
		
	if _can_attack == false:
		_animation_player.play(_attack_animation_name)
		return
		
	
	if !fly:	
		_hair.offset = Vector2(0,0)
		if velocity.x > 0 && velocity.y == 0:
			_animation_player.play("run_right")
			last_velocity = velocity
			return
		
		if velocity.x < 0  && velocity.y == 0:
			_animation_player.play("run_left")
			last_velocity = velocity
			return
		
		if velocity.y > 0 :
			_animation_player.play("run")
			last_velocity = velocity
			return
			
		if velocity.y < 0 :
			_animation_player.play("run_top")
			last_velocity = velocity
			return
			
		if last_velocity.y < 0 :
			_animation_player.play("idle_top")
			return
			
		if last_velocity.x < 0 && last_velocity.y == 0 :
			_animation_player.play("idle_left")
			return
			
		if last_velocity.x > 0 && last_velocity.y == 0:
			_animation_player.play("idle_right")
			return
			
		_animation_player.play("idle")
	else:
		_hair.offset = Vector2(0,3)
		if velocity.x > 0 && velocity.y == 0:
			_animation_player.play("fly_right")
			last_velocity = velocity
			return
		
		if velocity.x < 0  && velocity.y == 0:
			_animation_player.play("fly_left")
			last_velocity = velocity
			return
		
		if velocity.y > 0 :
			_animation_player.play("fly")
			last_velocity = velocity
			return
			
		if velocity.y < 0 :
			_animation_player.play("fly_top")
			last_velocity = velocity
			return
			
		if last_velocity.y < 0 :
			_animation_player.play("fly_top")
			return
			
		if last_velocity.x < 0 && last_velocity.y == 0 :
			_animation_player.play("fly_left")
			return
			
		if last_velocity.x > 0 && last_velocity.y == 0:
			_animation_player.play("fly_right")
			return
			
		_animation_player.play("fly")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_axe" or anim_name == "attack_hammer":
		_can_attack = true
		set_physics_process(true)

func update_collision_layer_mask() -> void:

	if fly:
		set_collision_layer_value(2,true)
		set_collision_layer_value(1,false)
		set_collision_mask_value(2,true)
		set_collision_mask_value(1,false)
		
		
	if !fly:
		set_collision_layer_value(2,false)
		set_collision_layer_value(1,true)
		set_collision_mask_value(2,false)
		set_collision_mask_value(1,true)


func _on_timer_timeout() -> void:
	can_fly = true;