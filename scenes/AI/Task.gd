extends Node2D

class_name Task

# States 

enum State{
	IDLE,
	INTEREST, #patrol
	GOINGTO,
	ATTACKING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

enum Action{
	NONE,
	MOVE,
	ATTACK,
	GETPRANKED
}
