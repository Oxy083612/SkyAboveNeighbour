extends Resource
class_name Prank

enum PrankType{
	BAD,
	GOOD,
}

@export var prankName: String
@export var prankRequiredItems: Array[Item]
@export var prankType: PrankType
@export var prankAnimation: String
@export var prankReady: bool
@export var prankDone: bool
