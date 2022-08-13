extends Node2D

var currIndex=0
var location="res://images/prj1/"
var savePath = "res://saves/save.res"
var dir = Directory.new()
var saveOrLoad:bool
var otherMenuOnScreen:int=0

func _ready():
	for panel in $"%saveLoadFiles".get_children():
		var button = panel.get_node("HBoxContainer/Button")
		button.connect("pressed", self, "saveLoadFile", [button.get_node("../Label")])

	var path=location+"im"+str(currIndex)+".png"
	get_node("Sprite").texture=load(path)

	#load_data
	var file = File.new()
	if file.open(savePath, File.READ)==OK:
		var read_dictionary = str2var(file.get_as_text())
		file.close()
		var saves =read_dictionary["saves"]
		for save in saves.keys():
			getSaveSlotByIndex(save).text=saves[save]
	else:
		push_error("yes")
		file.close()
		var file2 = File.new()
		file2.open(savePath, File.WRITE)
		file2.store_string(var2str({"saves": {}}))
		file2.close()


func _on_Button_pressed():
	if otherMenuOnScreen==0:
		addNextSprite(true)
	else:
		for i in [$"%pauseMenu", $"%quit", $"%save"]:
			i.hide()
		otherMenuOnScreen=0
#	var tween = get_tree().create_tween()
#	tween.tween_property($Sprite, "modulate", Color(1,1,1,0), .03)
#	tween.tween_callback(self, "addNextSpriteBefore")


#func addNextSpriteBefore():
#	var tween = get_tree().create_tween()
#	tween.tween_property($Sprite, "modulate", Color(1,1,1,1), .04)
#	tween.tween_callback(self, "addNextSprite")

func addNextSprite(nextOrPrev:bool):
	if nextOrPrev==true:
		currIndex+=1
	else:
		currIndex-=1
	var path=location+"im"+str(currIndex)+".png"
	get_node("Sprite").texture=load(path)



func _on_Button2_pressed():
	otherMenuOnScreen+=1
	$"%pauseMenu".visible= not $"%pauseMenu".visible
	$"%save".hide()
	$"%quit".hide()


func savebutt():
	$"%pauseMenu".hide()
	$"%save".show()
	saveOrLoad=true

func loadbutt():
	$"%pauseMenu".hide()
	$"%save".show()
	saveOrLoad=false


func quitButt():
	$"%pauseMenu".hide()
	$"%quit".show()


func _on_cancelQuit_pressed():
	otherMenuOnScreen-=1
	$"%quit".hide()


func _on_confirmQuit_pressed():
	get_tree().quit()

func saveLoadFile(label):
	if saveOrLoad==true:
		#in-game saving
		var time = OS.get_time()
		var date = OS.get_datetime()
		var time_return = addZeroOrMakeString(time.hour) +":"+addZeroOrMakeString(time.minute)+":"+addZeroOrMakeString(time.second)
		var day= date["day"]
		var month= date["month"]
		var date_return = addZeroOrMakeString(day) + "." +addZeroOrMakeString(month)
		label.text=date_return+ " " + time_return+"\nImage ID: " +String(currIndex)

		#in-file saving
		var indexOfPanel=label.get_node("../../").get_index()
		var file = File.new()
		file.open(savePath, File.READ_WRITE)
		var read_dictionary = str2var(file.get_as_text())
		read_dictionary["saves"][indexOfPanel]=label.text
		file.store_string(var2str(read_dictionary))
		file.close()

	else:
		if label.text!= "No save yet":
			currIndex=int(label.text.split("Image ID: ")[1])
			$"%save".hide()
			otherMenuOnScreen-=1
			var path=location+"im"+str(currIndex)+".png"
			get_node("Sprite").texture=load(path)

func addZeroOrMakeString(property):
	if property<10:
		property="0"+String(property)
	else:
		property=String(property)
	return property



func _on_prevButton_pressed():
	if otherMenuOnScreen==0:
		addNextSprite(false)
	else:
		for i in [$"%pauseMenu", $"%quit", $"%save"]:
			i.hide()
		otherMenuOnScreen=0


func getSaveSlotByIndex(index:int):
	return $"%saveLoadFiles".get_child(index).get_node("HBoxContainer/Label")









