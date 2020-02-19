extends KinematicBody2D

export var limit_y = 350
export var score = 10
export var speed = 2
export var move_probability = 0.2

var ready = false
var new_position = Vector2(0,0)

func get_new_position():
	var VP = get_viewport_rect().size
	new_position.x = randi() % int(VP.x)
	new_position.y = min(randi() % int(VP.y), int(VP.y) - limit_y)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	ready = true

func _ready():
	randomize()
	get_new_position()

func _physics_process(delta):
	if ready:
		$Tween.start()
		ready = false

func _on_Timer_timeout():
	if randf() < move_probability:
		get_new_position()
