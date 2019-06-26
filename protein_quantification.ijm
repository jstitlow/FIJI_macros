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

// Open Finder to choose directory
indir = "/Users/joshtitlow/tmp/AdultBrain_smFISH/test/";
//indir = getArgument();
list = getFileList(indir);

//setBatchMode(true);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

	// Open file
	open(path);

	// setup channels
   	run("Arrange Channels...", "new=23");
    image = getTitle();
    run("Split Channels");
    signal = "C1-" + image;
    mask = "C2-" + image;
    
    // process protein signal
    selectWindow(signal);
    run("Reverse");
    run("16-bit");
    run("Bleach Correction", "correction=[Exponential Fit]");
    run("Subtract Background...", "rolling=60 stack");
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
   	rename(image + "_mask_signal");
   	run("Measure");
	
    // apply inverted mask to protein image
    imageCalculator("Multiply create 32-bit stack", corrected_signal, corrected_invert_mask);
    run("Duplicate...", "duplicate range="+range);
    rename(image + "_invert_mask_signal");
    run("Measure");
    	
    // measure volume of both masks
    selectWindow(corrected_mask);
    run("Duplicate...", "duplicate range="+range);
    rename(image + "_mask_vol");
    run("Measure");

    selectWindow(corrected_invert_mask);
    run("Duplicate...", "duplicate range="+range);
    rename(image + "_inv_mask_vol");
    run("Measure");

    //while (nImages>0) {
    //         selectImage(nImages);
    //          close();
    //}

}

//saveAs("Results", indir+"Results.csv");

//setBatchMode(false);
