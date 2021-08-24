extends Node

var slowmo_active: bool = false

export(float) var normal_time_scale: float = 1.0
export(float) var slowmo_time_scale: float = 0.5

export(float) var slowmo_enter_time: float = 0.5
export(float) var slowmo_quit_time: float = 0.25

onready var tween = $Tween


func enter_slowmo_animation():
	tween.stop_all()
	tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 
			slowmo_time_scale, slowmo_enter_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	start_slowmo()

func exit_slowmo_animation():
	tween.stop_all()
	tween.interpolate_property(Engine, "time_scale", Engine.time_scale, 
			normal_time_scale, slowmo_quit_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	end_slowmo()

func start_slowmo():
	Engine.time_scale = slowmo_time_scale
	slowmo_active = true

func end_slowmo():
	Engine.time_scale = normal_time_scale
	slowmo_active = false

func request_slowmo_change():
	if !slowmo_active:
		enter_slowmo_animation()
	else:
		exit_slowmo_animation()
