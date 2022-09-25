# 這是所有狀態機的父節點
extends Node
class_name FiniteStateMachine

# 基礎定義
var stateList		: Dictionary 	= {}						# 儲存所有狀態 
var previous_state	: int 			= -1 						# 儲存前一個狀態
var state			: int 			= -1 	setget SetState		# 當下的狀態

# 基礎節點定義
onready var parent = get_parent()
onready var animation_player: AnimationPlayer = parent.get_node("AnimationPlayer")

# 每秒觸發該狀態需要做的事情
func _physics_process(delta: float) -> void:
	if state != -1:
		StateLogic(delta)
		var transition: int = GetTransition()
		if transition != -1:
			SetState(transition)

# 某裝狀態下需要觸發什麼事情(是需要每frame執行的事情)
func StateLogic(_delta: float) -> void:
	pass
	
# 某狀態下什麼情況下要做狀態轉換, -1 為不需要轉換
func GetTransition() -> int:
	return -1

# 初始宣告有哪些狀態
func AddState(new_state: String) -> void:
	stateList[new_state] = stateList.size()
	
# 轉換狀態, 執行上一個的結束狀態, 下一個的進入狀態
func SetState(new_state: int) -> void:
	ExitState(state)
	previous_state = state
	state = new_state
	EnterState(previous_state, state)

# 轉換狀態後當下需要做什麼
func EnterState(_previous_state: int, _new_state: int) -> void:
	pass
	
# 離開狀態前需要做什麼
func ExitState(_state_exited: int) -> void:
	pass
