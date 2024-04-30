extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -750.0
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 50)

	move_and_slide()
	update_animation()
	

func update_animation() -> void:
	if (velocity.y > 0):
		sprite.animation = "falling"
		return
	
	if (velocity.y < 0):
		sprite.animation = "jumping"
		return
	
	if (velocity.x != 0):
		sprite.animation = "running"
		return
	
	sprite.animation = "idle"

