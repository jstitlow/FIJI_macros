// Reduce multi-channel image to single channel
// Created 2 August 2018
//
// Specify channel in line 12

setBatchMode(true);

// Load files
indir = getDirectory("~/Desktop/test_batch");
list = getFileList(indir);

channel = 1;


// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];
		
		// Open file
		run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		
		// Start macro
		
		// Duplicate stack and select specific channel
		original = getTitle();
		run("Duplicate...", "duplicate channels=channel"); 
		copy = getTitle();
		selectWindow(original);
		close();
		saveAs("Tiff", indir+copy);
}

		