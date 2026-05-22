extends AudioStreamPlayer2D
const DRZWI = preload("uid://8qggbl1rqlhi")
const ELEKTRYCZNOSC = preload("uid://88wkpmi60dkd")
const ENEMY_ANGY = preload("uid://cc177yajxjax6")
const ENEMY_KROKI = preload("uid://ij4javoddta1")
const MEOW = preload("uid://bu3vlrebcpbsu")
const PICIE = preload("uid://rl2vlsjr6gr3")
const PRZYCEGLE = preload("uid://hflxsmm80hku")
const STUDENT_HAPPY_JUMP = preload("uid://bo35ql4mm5ubt")
const STUDENT_IDK = preload("uid://cgd3v7lj3jegs")
const STUDENT_KOMBINUJE = preload("uid://drgh0rilhorfo")
const STUDENT_KROKI = preload("uid://dyyjgdb7878qq")
const STUDENT_POMYSL = preload("uid://bm6w037i6djpj")
const STUDENT_SMIECH_2 = preload("uid://bptvup7er04co")
const STUDENT_SMIECH = preload("uid://rpn0m05knone")
const STUDENT_ZASTANOWIENIE_2 = preload("uid://co6wpe1ecg6t6")
const STUDENT_ZASTANOWIENIE = preload("uid://cmo24g3ef1sml")
const UPADEK_1 = preload("uid://dfv1un42uwllu")
const UPADEK_2 = preload("uid://bkpqsk5cr6nky")
const WYLEW = preload("uid://e66g72i8mxl7")

func playsound(sound) -> void:
	if not finished.is_connected(_on_finished):
		finished.connect(_on_finished)
	var toplay = MEOW
	match sound:
		"fall":
			toplay=[UPADEK_1,UPADEK_2].pick_random()
		"krokenemy":
			toplay=ENEMY_KROKI
		"krokplayer":
			toplay=STUDENT_KROKI
		"pickup":
			toplay=MEOW
		"idk":
			toplay=STUDENT_IDK
		"prankdo":
			toplay=STUDENT_SMIECH
	set_stream(toplay)
	play()
func _on_finished() -> void:
	stop() 
