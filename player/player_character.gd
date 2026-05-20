class_name PlayerCharacter
extends Node2D
@onready var inventory: Inventory = %Control

enum State {
	IDLE,
	WALK,
	HIDDEN,
	DOOR_VAULT,
	CREEP,
	INTERACTING,
}

enum Action {
	NONE,
	MOVE,
	HIDE,
	PICKUP,
	PRANK
}

@export var speed := 200.0
var target_x := 0
var target_y := 0
var CurrentState := State.IDLE
var is_hidden := false
var _interaction_y := 0
var _pending_action := Action.NONE
var item_container
var current_room: Room = null
var current_prank: Prank = null

func _init() -> void:
	SignalBus.movement_action.connect(_on_move)
	SignalBus.hiding_action.connect(_on_hide)
	SignalBus.pickup_action.connect(_on_pickup)
	SignalBus.prankdo_action.connect(_on_prankdo)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_x = position.x
	target_y = position.y

func _on_move(x, y) -> void:
	target_x = x
	position.y = y
	_pending_action = Action.MOVE
	set_state(State.WALK)
	
	
func _on_hide(x, y, spot_y) -> void:
	target_x = x
	position.y = y
	_interaction_y = spot_y
	_pending_action = Action.HIDE
	set_state(State.WALK)
	
func _on_pickup(x, y, contener) -> void:
	target_x = x
	position.y = y
	item_container = contener as ItemPickup
	_pending_action = Action.PICKUP
	set_state(State.WALK)
	
func _on_prankdo(x, y, prank) -> void:
	target_x = x
	position.y = y
	current_prank = prank
	_pending_action = Action.PRANK
	set_state(State.WALK)
	
func set_state(state) -> void:
	exit_state()
	CurrentState = state
	enter_state(state)
	
func enter_state(state) -> void:
	match state:
		State.IDLE:
			pass
		State.WALK:
			pass
		State.HIDDEN:
			is_hidden = true
			position.y = _interaction_y
		State.DOOR_VAULT:
			pass
		State.CREEP:
			pass
		State.INTERACTING:
			pass
			
func exit_state() -> void:
	match CurrentState:
		State.IDLE:
			pass
		State.WALK:
			pass
		State.HIDDEN:
			position.y = 450
		State.DOOR_VAULT:
			pass
		State.CREEP:
			pass
		State.INTERACTING:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentState == State.WALK:
		var dir = sign(target_x - position.x)
		position.x += dir * speed * delta

		if abs(position.x - target_x) < 5:
			state_handler()
	
		
		
func state_handler() -> void:
	match _pending_action:
		Action.MOVE:
			_pending_action = Action.NONE
			item_container = null
			set_state(State.IDLE)

		Action.HIDE:
			_pending_action = Action.NONE
			item_container = null
			set_state(State.HIDDEN)

		Action.PICKUP:
			_pending_action = Action.NONE
			if not item_container.is_empty:	
				for item in item_container.items:
					inventory.addItem(item)
				item_container.is_empty = true
			item_container = null
			set_state(State.IDLE)

		Action.NONE:
			set_state(State.IDLE)
		Action.PRANK:
			_pending_action = Action.NONE
			var has_all_items = true 
			for item in current_prank.prankRequiredItems:
				if not inventory.checkItem(item.itemName):
					has_all_items = false
					print("Cant do prank. Missing item: " + item.itemName)
					break
			if has_all_items:
				print("Prank done: " + current_prank.prankName)
				for item in current_prank.prankRequiredItems:
					inventory.removeItem(item.itemName)
			current_prank = null
			set_state(State.IDLE)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_class("Room"):
		var room = body as Room
		print(room)
		current_room = room
