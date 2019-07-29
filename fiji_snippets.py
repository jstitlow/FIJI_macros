########################################################
# Accessory jython code for protein_quantification.ijm
#
# -runs macro
# -gets image from processed image 
# -calculate RawIntDen
#    -IJ Results window does not work in --headless mode
#
# --USAGE---
#  -run from command line:
# 
# --doesn't work --headless because it loses windows
# 
#
########################################################


from ij import IJ 
from java.io import File
from ij.macro import MacroRunner
from ij import WindowManager as WM
import os

import os.path
import time

print "jython code works from the command line!"

macropath = "/Users/joshtitlow/Downloads/protein_quantification.ijm"
macrofile =  File(macropath)
mr = MacroRunner(macrofile)
print mr

my_file = "/Users/joshtitlow/tmp/AdultBrain_smFISH/test/test.tif"

while not os.path.exists(my_file):
    time.sleep(10)

mask_signal = WM.getImage('mask_signal')
ip = mask_signal.getProcessor().convertToFloat() 
pixels = ip.getPixels()
RawIntDen = sum(pixels)
print RawIntDen

print "macro worked"


#if os.path.isfile(my_file):
#    print "file ready"
#else:
#    print "file does not exist"

#my_file = "/Users/joshtitlow/tmp/AdultBrain_smFISH/test.csv"
#value = os.path.isfile(my_file)
#print value

#while value != "True":
	#
#macropath = "/Users/joshtitlow/src_FIJI_macros/py_macro.ijm"
#macrofile =  File(macropath)
#mr = MacroRunner(macrofile)

#print "done"

#mask_signal = WM.getImage('mask_signal')
#ip = mask_signal.getProcessor().convertToFloat() 
#pixels = ip.getPixels()
#RawIntDen = sum(pixels)
#print RawIntDen

#macropath = "/Users/joshtitlow/Downloads/protein_quantification.ijm"
#macrofile =  File(macropath)
#mr = MacroRunner(macrofile)

#mask_signal = WM.getImage('mask_signal')
#ip = mask_signal.getProcessor().convertToFloat() 
#pixels = ip.getPixels()
#RawIntDen = sum(pixels)
#print RawIntDen

#ip = mask_signal.getProcessor().convertToFloat() 
#ip.type()

#import os
#my_file = "/Users/joshtitlow/tmp/AdultBrain_smFISH/test.csv"
#value = os.path.isfile(my_file)
#print value

#while value != "True":
	#
#print "done"

#else:
#	print "false"
	
#while count<10:
#   count = count+1
#   print "count = ",count
#print "Good Bye!"


#invert_mask_signal = IJ.getImage(invert_mask_signal)
#mask_vol = IJ.getImage(mask_vol)
#inv_mask_vol = IJ.getImage(inv_mask_volsk_vol)

#from ij import IJ 
#image = "file1.r3d"
#imp = IJ.getImage("file1.r3d")
#ip = imp.getProcessor().convertToFloat()  
#pixels = ip.getPixels()
#RawIntDen = sum(pixels)
#print RawIntDen

# Grab currently active image  
#imp = IJ.getImage()  
#IJ.run(imp, "Median...", "radius=2");

#imp = IJ.openImage("http://imagej.net/images/blobs.gif")
#ip = imp.getProcessor().convertToFloat()  
#pixels = ip.getPixels()  
#RawIntDen = sum(pixels)
#print RawIntDen
  
# Compute the mean value (sum of all divided by number of pixels)  
#format = 506*506
#print "Total # of pixels = ", format
#print "IJ # of pixels = ", imp.width * imp.height
#print "# of missing pixels = ", format - len(pixels)
#print "# of 0 intensity pixels = ", sum(x == 0 for x in pixels)


