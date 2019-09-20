// -select ROI
// -run code
// -first measurement is masked GB from single slice
// -second measurement is background

// specify indir
indir = "/Users/joshtitlow/Downloads/";

// create a file to store calculations
outfileprocessed = indir + "ResultsProcessed.txt"

// isolate data channel
run("Duplicate...", "duplicate channels=3");
original = getTitle();
slice = getSliceNumber();
run("Duplicate...", "duplicate");
data = getTitle();

// threshold the enriched signal and calculate area
setAutoThreshold("RenyiEntropy dark no-reset");
run("Convert to Mask", "method=RenyiEntropy background=Dark black");
run("Divide...", "value=255 stack");
run("Measure");
maskarea = getResult("RawIntDen", nResults-1);
imageCalculator("Multiply create stack", original, data);
setSlice(slice);
run("Measure");
masksignal = getResult("RawIntDen", nResults-1);
close();
selectWindow(data);
close();

// isolate background
selectWindow(original);
run("Duplicate...", "duplicate");
background = getTitle();
setAutoThreshold("RenyiEntropy no-reset");
run("Convert to Mask", "method=RenyiEntropy background=Light black");
run("Divide...", "value=255 stack");
run("Measure");
invmaskarea = getResult("RawIntDen", nResults-1);
imageCalculator("Multiply create stack", original, background);
setSlice(slice);
run("Measure");
maskbackground = getResult("Mean", nResults-1);
close();
selectWindow(background);
close();
selectWindow(original);
close();

// save the raw analysis and ROIs
Table.save(indir+"GB_intensity.csv");
roiManager("Save", indir+original+".zip");

// calculate signal and append to ResultsProcessed file
meanSignal = masksignal/maskarea;
meanBackground = maskbackground/invmaskarea;
GBsignal = meanSignal/meanBackground;
File.append(original+" "+GBsignal, outfileprocessed);
