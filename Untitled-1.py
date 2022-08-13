from PIL import Image
from pytesseract import pytesseract
import numpy as np
import cv2
import pyautogui
import time
import jellyfish

#change width and height for higher/lower image resolution depending on memory you can use. 960x540 is around 130kb, and 1920x1080 around 3mb for reference
#default is 960x540
def image_resize(image, width = None, height = None, inter = cv2.INTER_AREA):
    # initialize the dimensions of the image to be resized and
    # grab the image size
    dim = None
    # (h, w) = image.shape[:2]

    # if both the width and height are None, then return the
    # original image
    if width is None and height is None:
        return image

    # check to see if the width is None
    if width is None:
        # calculate the ratio of the height and construct the
        # dimensions
        r = height / float(1080)
        dim = (int(1920 * r), height)

    # otherwise, the height is None
    else:
        # calculate the ratio of the width and construct the
        # dimensions
        r = width / float(1920)
        dim = (width, int(1080 * r))

    # resize the image
    resized = cv2.resize(image, dim, interpolation = inter)

    # return the resized image
    return resized

lastText=""
    #will overwrite already existing photos, but you can probably do some code that solves it
index=0
    #path to tesseract.exe
path_to_tesseract = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
    #path to godot Project
path_to_godot_project = r'C:\Users\XXX\Documents\photoScanner\images/\prj1'
    #Point tessaract_cmd to tessaract.exe
pytesseract.tesseract_cmd = path_to_tesseract
while True:
    pyautogui.click()
    time.sleep(0.2)
    image = pyautogui.screenshot(region=(0,1080-400-30, 1920, 400))
    image = cv2.cvtColor(np.array(image),
                        cv2.COLOR_RGB2BGR)
    
    text = pytesseract.image_to_string(image)
        #checks if text in images is not the same
    if not(text=="" or jellyfish.levenshtein_distance(text[0:len(lastText)+1], lastText)<6):
        img=pyautogui.screenshot(region=(0,0, 1920, 1080))
        img = cv2.cvtColor(np.array(img),
                        cv2.COLOR_RGB2BGR)
        img=image_resize(img, width=960, height=540)
        cv2.imwrite(path_to_godot_project+"\\"+"im"+str(index)+".png", img)
        index+=1
    lastText=text
  