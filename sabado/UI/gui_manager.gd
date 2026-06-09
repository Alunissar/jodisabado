extends Node
class_name GUIManager

@onready var hp_label: LabelPlus = $BottomBar/PlayerStatScreen/HPLabel
@onready var atk_label: LabelPlus = $BottomBar/PlayerStatScreen/ATKLabel
@onready var def_label: LabelPlus = $BottomBar/PlayerStatScreen/DEFLabel

func _ready() -> void:
	GameManager.ui_manager = self

func update_stats() -> void:
	hp_label.text_set(Global.insert_group_splitters(str(PCInstance.HP)))
	atk_label.text_set(Global.insert_group_splitters(str(PCInstance.ATK)))
	def_label.text_set(Global.insert_group_splitters(str(PCInstance.DEF)))
