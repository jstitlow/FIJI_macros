/* NMJ mask for smFISH
 *  3 January 2017
 */

/*
input = "/Volumes/bioc1301/data/20170111_Orb2GFP_stim_smFISH/NMJs/Cropped/";
output = "/Volumes/bioc1301/data/20170111_Orb2GFP_stim_smFISH/NMJs/Cropped/output";

setBatchMode(true); 
list = getFileList(input);
for (i = 0; i < list.length; i++)
        action(input, output, list[i]);
setBatchMode(false);
*/

// smFISH (signal) is channel 1, HRP (marker) is channel 3 
title1 = getTitle();
run("Duplicate...", "duplicate");

title2 = getTitle();
run("Arrange Channels...", "new=24");
run("Split Channels");
signal = "C1-" + title2; 
mask = "C2-" + title2;

// Make sure variables aren't screwed up
// print(c1Title);
// print(c2Title);

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

/*
selectWindow(title1);
run("Split Channels");
c1Title1 = "C1-" + title1; 
c2Title1 = "C2-" + title1;
run("Merge Channels...", "c1=["+c1Title1+"] c2=["+c2Title1+"] c3=["+Product1+"] create");
*/