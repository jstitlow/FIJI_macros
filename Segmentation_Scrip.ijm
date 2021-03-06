/* Segmentation script to measure signal intensity within marker  
 *  6 July 2017
 *  Prints measurement of MAX projected threshold channel
 *  From which the raw int density = mask volume in pixels 
 *  Prints measurement of SUM projected signal channel
 *  From which the mean can be used as a measure of signal intensity
 */

// Open Finder to choose directory
dir1 = getDirectory("/Volumes/bioc1301/data/20160929_Gal80_FISH/Files/");
list = getFileList(dir1);

setBatchMode(true);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=dir1+list[i];
	
		// Open file
		run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");

// Macro starts here


title1 = getTitle();
run("Duplicate...", "duplicate");

// Immunofluorescence (signal) is channel 1, HRP (marker) is channel 1 
title2 = getTitle();
run("Arrange Channels...", "new=12");
run("Split Channels");
signal = "C1-" + title2; 
mask = "C2-" + title2;

// Make sure variables aren't screwed up
//print(c1Title);
//print(c2Title);

selectWindow(mask);
run("Threshold...");
setOption("BlackBackground", false);

// RenyiEntropy works reasonably well, could try others
run("Convert to Mask", "method=RenyiEntropy background=Default calculate");
run("Divide...", "value=255.000 stack");
Product1 = getTitle();
run("Duplicate...", "duplicate");
Product2 = getTitle();
run("Z Project...", "projection=[Max Intensity]");
Max = getTitle();
run("Measure");
selectWindow(Product2);
close();
selectWindow(Max);
close();

selectWindow(Product1);
setAutoThreshold("RenyiEntropy");
imageCalculator("Multiply create stack", Product1, signal);
Product3 = getTitle();
run("Z Project...", "projection=[Sum Slices]");
Sum= getTitle();
run("Measure");


selectWindow(Product3);
close();

selectWindow(Sum);
close();

selectWindow(Product1);
close();
selectWindow(signal);
close();

selectWindow(title1);
close();
}
