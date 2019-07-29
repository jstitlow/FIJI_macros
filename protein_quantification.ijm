/* Segmentation script to measure signal intensity within marker
 *   26 June 2019
 *
 *  -Measures intensity from  a masked image (2um volume) in the center of a z-stack
 *  -Records volume of the mask (_mask_vol RawIntDen)
 *
 *  --IMAGE PROCESSING--
 *
 *   -Normalise z intensity with 'Bleach Correction' algorithm
 *   -Sharpen and flatten field with 'Subtract Background' algorithm
 * 
 *  --USAGE--
 *
 *   -Call from the command line:
 *   > fiji --headless --console -macro ~/src/FIJI_macros/protein_quantification.ijm /path/to/directory
 *
 */


//run("ImageJ2...", "scijavaio=true loglevel=INFO");
//run("Set Measurements...", "area mean standard min max integrated limit display redirect=None decimal=3");


//setBatchMode(true);

// setup channels and outfile
indir = "/Users/joshtitlow/tmp/AdultBrain_smFISH/test/";
//indir = getArgument();
//outdir = "/Users/joshtitlow/tmp/AdultBrain_smFISH/Results/"'
list = getFileList(indir);
openfile = File.open("/Users/joshtitlow/src/FIJI_Macros/Results.txt");
headings = "Label	Area	Mean	StdDev	Min	Max	IntDen	RawIntDen	MinThr	MaxThr";
print (openfile, headings);
File.close(openfile);
outfile = "/Users/joshtitlow/src/FIJI_Macros/Results.txt"

// function to append results table
// call with print_results(imageID, outfile);
function print_results(imageID, outfile){
	Label = imageID;
	Area = getResult("Area", 0);
	Mean = getResult("Mean", 0);
	StdDev = getResult("StdDev", 0);
	Min = getResult("Min", 0);
	Max = getResult("Max", 0);
	IntDen = getResult("IntDen", 0);
	RawIntDen = getResult("RawIntDen", 0);
	MinThr = getResult("MinThr", 0);
	MaxThr = getResult("MaxThr", 0);
	File.append(Label+" "+Area+" "+Mean+" "+StdDev+" "+Min+" "+Max+" "+IntDen+" "+RawIntDen+" "+MinThr+" "+MaxThr, outfile);
}

run("Close All");


// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

	// Open file
	open(path);

	// setup channels
    //run("Arrange Channels...", "new=23");
    image = getTitle();
    run("Split Channels");
    signal = "C2-" + image;
    mask = "C3-" + image;

	// process protein signal
    selectWindow(signal);
    run("Reverse");
    run("Slice Remover", "first=1 last=5 increment=1");
    run("Divide...", "value=255 stack");
    run("16-bit");
    run("Bleach Correction", "correction=[Exponential Fit]");
    run("Subtract Background...", "rolling=60 stack");
	run("32-bit");    	
   	run("Multiply...", "value=255 stack");
   	corrected_signal = getTitle();

   	// create mask
   	selectWindow(mask);
   	run("Reverse");
   	run("Subtract Background...", "rolling=60 stack");
   	run("Convert to Mask", "method=Otsu background=Dark calculate");

   	// code for testing alternative threshold algorithm
   	// run("Convert to Mask", "method=MaxEntropy background=Dark calculate");
   	run("Divide...", "value=255 stack");
   	corrected_mask = getTitle();

   	// create inverted mask to determine if 'background' changes
   	// convert to 32 bit to accept negative values
   	run("Duplicate...", "duplicate");
   	run("32-bit");
   	run("Subtract...", "value=1 stack");
   	run("Abs", "stack");
   	corrected_invert_mask = getTitle();

   	// apply mask to protein image in 2um volume at the center of the image
   	imageCalculator("Multiply create 32-bit stack", corrected_signal, corrected_mask);
   	middle_slice = floor((nSlices()/2))+1;
   	range_min = maxOf(middle_slice -5,1);
   	range_max = minOf(nSlices(),middle_slice +5);
   	range = "" + range_min + "-" + range_max;
   	run("Duplicate...", "duplicate range="+range);
	run("Z Project...","projection=[Sum Slices]");
   	run("Measure");
   	//rename(image + "_mask_signal");
	print_results(image + "_mask_signal", outfile);

   	// apply inverted mask to protein image
   	imageCalculator("Multiply create 32-bit stack", corrected_signal, corrected_invert_mask);
   	run("Duplicate...", "duplicate range="+range);
   	run("Z Project...","projection=[Sum Slices]");
   	run("Measure");
   	//rename(image + "_invert_mask_signal");
   	print_results(image + "_invert_mask_signal", outfile);

   	// measure volume of both masks
   	selectWindow(corrected_mask);
   	run("Duplicate...", "duplicate range="+range);
   	run("Z Project...","projection=[Sum Slices]");
   	run("Measure");
   	//rename(image + "_invert_mask_signal");
   	print_results(image + "_mask_vol", outfile);
   	
   	selectWindow(corrected_invert_mask);
   	run("Duplicate...", "duplicate range="+range);

   	run("Z Project...","projection=[Sum Slices]");
   	run("Measure");
   	//rename(image + "_inv_mask_vol");
	print_results(image + "_invert__mask_vol", outfile);
    // tidy up
    //run("Clear Results");
    //run("Close All")
   
}

//setBatchMode(false);
