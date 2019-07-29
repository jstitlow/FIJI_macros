/* Run 3D object counter
 * 9 July 2019
 */

setBatchMode(true);

// load files
indir = "/Users/joshtitlow/tmp/eif4e_experiment/raw_data/";
list = getFileList(indir);

// set up loop to process all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	image_name = list[i];
	path=indir+list[i];
	
	// start macro
		
	// open file
	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");

	// get single channel
	run("Arrange Channels...", "new=3");

	// run 3D objects counter
	run("3D Objects Counter", "threshold=125 slice=32 min.=4 max.=200 centroids statistics summary");

	// save results
	saveAs("Results", indir+ substring(image_name, 0, lengthOf(image_name)-4) + "_objs.csv");

}

setBatchMode(false);
