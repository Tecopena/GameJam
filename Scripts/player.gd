extends CharacterBody2D

@export var speed :float = 300.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree:AnimationTree = $AnimationTree
@onready var state_machine:PlayerStateMachine = $PlayerStateMachine


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction :Vector2 = Vector2.ZERO
var has_doubled_jumped:bool = false;
var animation_lock:bool = false;
var was_in_air : bool = false

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	direction = Input.get_vector("left", "right","jump","crouch")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	move_and_slide()
	update_animation()
	update_facing_direction()
	

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h =false
	elif direction.x < 0:
		sprite.flip_h =true

func _process(delta):
	pass

func _input(event : InputEvent):
	# move o player para baixo se ele estiver em cima de uma plataforma atravessavel
	if event.is_action_pressed("crouch") and is_on_floor():
		position.y += 1
	
	
