extends CharacterBody3D
class_name PlayerPawn
var speed = 5.0 #adsfsdafas'dflkjsad'f;jkasddfsjkafd'jasdf;klasf;lkasdf;lhasdfl;kas;flkjasdfjasf;ljasf;jl
var direction = Vector3.ZERO
var input_dir = Vector2.ZERO


const JUMP_FORCE = 5.0
const SPEED_FORCE = 5.0

const WALK_SPEED = 4.0
const SPRINT_SPEED = 5.0

const GRAVITY_MOD = 1.5
const FREQUENCY_MOD = 5.0

var hop_count = 0
var can_jump = true
var on_floor = false

signal on_jump()
signal moving()
signal in_air()
func _ready() -> void:
	$can_jump_timer.timeout.connect(func():can_jump = true)
func _process(delta: float) -> void:
	if Input.is_action_pressed("SPACE"):
		if on_floor and can_jump:
			can_jump = false
			jump()
			$can_jump_timer.start()
	if Input.is_action_just_released("SPACE"):
		hop_count = 0
	input_dir = Input.get_vector("A", "D", "W", "S")
func _physics_process(delta: float) -> void:
	on_floor = is_on_floor()
	#on_floor = true
	global_rotation.y = %fps.cam_rotation_y
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * Vector3(1,0,1)
	if !on_floor:
		in_air.emit()
		velocity += get_gravity() * GRAVITY_MOD * delta
	else:
		if direction:
			moving.emit()
		velocity.x = lerpf(velocity.x,direction.x * WALK_SPEED,FREQUENCY_MOD*delta)
		velocity.z = lerpf(velocity.z,direction.z * WALK_SPEED,FREQUENCY_MOD*delta)
		
	move_and_slide()
func jump():
	hit(Vector3.UP*JUMP_FORCE * GRAVITY_MOD + direction * SPEED_FORCE) 
	hop_count+=1
	on_jump.emit()
func hit(force):
	velocity = force
