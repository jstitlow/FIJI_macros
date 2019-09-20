/* Segmentation script to measure signal intensity within mask
 *   8 August 2019
 *
 *  -Measures intensity from  a masked image in 3D
 *  -Records volume of the mask (_mask_vol RawIntDen)
 *
 *  --IMAGE PROCESSING--
 *
 *   -Sharpen and flatten field with 'Subtract Background' algorithm
 *
 *  --USAGE--
 *   -check that channels are setup properly
 *   -can call from command line
 *       fiji --headless --console -macro ~/src/FIJI_macros/NMJ_signal_processing.ijm path/to/directory/
 */


setBatchMode(true);
run("Set Measurements...", "area mean standard min max integrated limit display redirect=None decimal=3");

// setup channels and outfile
//indir = "/Users/joshtitlow/OneDrive - Nexus365/SypPaper/Data/FINAL/GB_intensity_analysis/20170726/";
indir = getArgument();
//indir = getDirectory();
//outdir = "/Users/joshtitlow/tmp/AdultBrain_smFISH/Results/"'
list = getFileList(indir);

data_channel = 1;
mask_channel = 3;

// create a file to store calculations
outfileprocessed = indir + "ResultsProcessed.txt"

run("Close All");
// iterate through directory
for (i=0; i<list.length; i++) {
	if(endsWith(list[i],".tiff")){
    showProgress(i+1, list.length);
    print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
    path=indir+list[i];

	// open file with Bioformats
	open(path);
	//run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");
	//rename("original");
	original = getTitle();
	
	// process data channel
	run("Duplicate...", "duplicate channels=" +data_channel);
	rename("data");
	run("Subtract Background...", "rolling=50 stack");
	//data = getTitle();
	
	// create mask
	selectWindow(original);
	run("Duplicate...", "duplicate channels=" +mask_channel);
	//rename("mask");
	//mask = getTitle();
	run("8-bit");
	middle_slice = floor((nSlices()/2))+1;
	setSlice(middle_slice);
	setAutoThreshold("Otsu dark no-reset");
	run("Convert to Mask", "method=Otsu background=Light");
	run("Dilate", "stack");
	run("Dilate", "stack");
	run("Dilate", "stack");
	run("Dilate", "stack");
	run("Dilate", "stack");
	run("Dilate", "stack");
	run("Dilate", "stack");
	//run("Dilate", "stack");
	//run("Dilate", "stack");
	//run("Dilate", "stack");
	//run("Dilate", "stack");
	//run("Dilate", "stack");
	//run("Dilate", "stack");
	run("Convert to Mask", "method=Otsu background=Dark black");
	run("Divide...", "value=255 stack");
	rename("mask");
	run("Z Project...", "projection=[Sum Slices]");
	run("Measure");
	maskvolume = getResult("RawIntDen", nResults-1);

	// apply mask
	imageCalculator("Multiply create stack", "data", "mask");
	product = getTitle();
	print(product);
	run("Z Project...", "projection=[Sum Slices]");
	run("Measure");
	totalsignal = getResult("RawIntDen", nResults-1);
	meanSignal = totalsignal/maskvolume;
	File.append(list[i]+" "+meanSignal, outfileprocessed);
	
	}
}

// save the raw analysis and ROIs
Table.save(indir+"NMJ_intensity.csv");

setBatchMode(false);
run("Quit");

