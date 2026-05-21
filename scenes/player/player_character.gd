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
	PRANK,
	DOOR,
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
var target_destination: Marker2D = null
var current_prank: Prank = null
var target_floor: int = 0
@export var floor_level:= 0
@export var floor_manager: FloorManager

func _init() -> void:
	SignalBus.movement_action.connect(_on_move)
	SignalBus.hiding_action.connect(_on_hide)
	SignalBus.pickup_action.connect(_on_pickup)
	SignalBus.prankdo_action.connect(_on_prankdo)
	SignalBus.door_action.connect(_on_door_vault)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("narrowing_conversion")
	target_x = global_position.x
	global_position.y = floor_manager._get_floor_position(floor_level)
	print(global_position.y)

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
	
func _on_door_vault(x, y, destination, _floor_level) -> void:
	target_floor = _floor_level
	target_x = x
	position.y = y
	target_destination = destination
	_pending_action = Action.DOOR
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
			print("target_x: ", target_x)
			pass
		State.HIDDEN:
			is_hidden = true
			global_position.y = _interaction_y
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
			global_position.y = floor_manager._get_floor_position(floor_level)
		State.DOOR_VAULT:
			pass
		State.CREEP:
			pass
		State.INTERACTING:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentState == State.WALK:
		var dir = sign(target_x - global_position.x)
		global_position.x += dir * speed * delta

		if abs(global_position.x - target_x) < 5:
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
					inventory.removeItem(item)
			current_prank = null
			set_state(State.IDLE)
			
		Action.DOOR:
			floor_level = target_floor
			_pending_action = Action.NONE
			position.y = target_destination.position.y
			item_container = null
			target_destination = null
			set_state(State.IDLE)
			
		Action.NONE:
			set_state(State.IDLE)
			


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Room:
		current_room = area.get_parent()
		
