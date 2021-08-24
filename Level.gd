extends Node2D


onready var slowmoController = $SlowmoController


func _physics_process(delta):
	if Input.is_action_just_pressed("ability_slowmo"):
		slowmoController.request_slowmo_change()
