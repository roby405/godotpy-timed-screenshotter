# godotpy-timed-screenshoter
screenshot visual novels to create a very barebones port of the game for phones/pc without audio/animations/anything

It's literally a screenshot reader.

How it works: open a visual novel or something text based where you don't need to make any interaction.

Set text speed or whatever you have at instant.

Get all the imported libraries and tesseract too if you want it

Modify in the python script the paths of the godot project and pytesseract if you want to use it (add the godot project in Documents if you didn't already)

Change image resolution if you want, but you have to change scale for sprite in godot project.

After that, run the script and open the visual novel and let it run for a while


After you're done with the screenshots, open the godot project, let the images import, test that it works, then export to android/pc. Size for a couple of hours of reading should be 500mb+ but you can delete if afterwards. Has saving and loading, and next and previous line(in this case image) button.



You can probably use this for other things too, like screenshots for lessons or youtube videos. You might want to delete pyautogui.click() line and change the sleep timer though.
