extends Node

class_name	State

@export var can_move = true;

var character :CharacterBody2D
var next_state:State
var playback:AnimationNodeStateMachinePlayback

func state_proceess(delta):
	pass

func state_input(event: InputEvent):
	pass

func on_enter():
	pass
	
func on_exit():
	pass
