extends CharacterBody3D
class_name PlayerCharacter

@onready var camera: Camera3D = $"../Camera"
@onready var mesh: CollisionShape3D = $CollisionShape3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROT_SPEED = 15

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("in_left", "in_right", "in_up", "in_down")
	var direction := (camera.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		var target_angle = Vector3.BACK.signed_angle_to(direction, Vector3.UP)
		var current_angle = Vector3.BACK.signed_angle_to(mesh.global_basis.z, Vector3.UP)
		
		target_angle = lerp_angle(current_angle, target_angle, 1)
		
		if(abs(target_angle - current_angle) > ROT_SPEED * delta):
			mesh.global_rotation.y += sign(target_angle - current_angle) * ROT_SPEED * delta
		else:
			mesh.global_rotation.y += target_angle - current_angle
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
