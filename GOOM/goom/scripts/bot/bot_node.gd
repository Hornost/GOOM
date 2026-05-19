extends Entity
@export var bot_resource: BotResource
var desired_velocity = Vector3.ZERO
func _ready() -> void:
	bot_resource.bot_ai.velocity_changed.connect(func(from,to):desired_velocity = to)
	
	$think_timer.timeout.connect(_think)
func _think():
	bot_resource.bot_ai.think()
func _process(delta: float) -> void:
	$billboard_mesh.global_rotation_degrees.y = rad_to_deg(Vector2(bot_resource.bot_ai.direction.z,bot_resource.bot_ai.direction.x).angle())
	bot_resource.bot_ai.bot_pawn_velocity = velocity
	bot_resource.bot_ai.bot_pawn_position = global_position
	if !is_on_floor():
		velocity.y = get_gravity().y/2
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	move_and_slide()
