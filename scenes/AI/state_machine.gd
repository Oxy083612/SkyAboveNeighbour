# StateMachine.gd

class_name StateMachine
extends Node

@export var initial_state : NodePath

var current_state : StateEnemy
var states := {}

func _ready():

	for child in get_children():

		if child is StateEnemy:

			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_state:

		current_state = get_node(initial_state)

		if current_state:
			current_state.Enter()


func _process(delta):
	#print(get_parent().)

	if current_state:
		current_state.Update(delta)


func _physics_process(delta):
	print(current_state)
	if current_state:
		current_state.Physics_Update(delta)


func on_child_transition(state, new_state_name):

	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		return

	current_state.Exit()

	current_state = new_state

	current_state.Enter()
