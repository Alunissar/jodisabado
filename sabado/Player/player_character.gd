extends CharacterBody3D
class_name PlayerCharacter

@onready var camera: Camera3D = $"../Camera"
@onready var mesh: CollisionShape3D = $CollisionShape3D
@onready var ray_cast: RayCast3D = $Interaction_RayCast3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROT_SPEED = 15

var input_dir : Vector3

func _input(event: InputEvent) -> void:
	
	var input = Input.get_vector("in_left", "in_right", "in_up", "in_down")
	
	input_dir = camera.basis * Vector3(input.x, 0, input.y)
	input_dir.y = 0
	input_dir = input_dir.normalized()
	
	if Input.is_action_just_pressed("in_act"):
		ray_cast.target_position = -mesh.global_basis.z
		
		pass
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity()*2 * delta
	
	var move_vec = input_dir * SPEED
	
	if get_floor_angle(Vector3.UP) > 0.4:
		floor_stop_on_slope = false
		move_vec += get_floor_normal() * SPEED
	else:
		floor_stop_on_slope = true
		pass
	
	if move_vec:
		velocity.x = move_vec.x 
		velocity.z = move_vec.z
		
		# Rotate
		if(not Input.is_action_pressed("in_target")):
			var target_angle = Vector3.BACK.signed_angle_to(move_vec, Vector3.UP)
			var current_angle = Vector3.BACK.signed_angle_to(-mesh.global_basis.z, Vector3.UP)
			
			target_angle = lerp_angle(current_angle, target_angle, 1)
		
			if(abs(target_angle - current_angle) > ROT_SPEED * delta):
				mesh.global_rotation.y += sign(target_angle - current_angle) * ROT_SPEED * delta
			else:
				mesh.global_rotation.y += target_angle - current_angle
				pass
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		pass
	
	
	
	move_and_slide()
	
