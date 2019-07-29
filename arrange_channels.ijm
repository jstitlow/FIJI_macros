/* Get single channel for FISHquant analysis
 * 10 July 2019
 *
 * INPUT DATASET:
 * > directory of images
 *
 *
 * SCRIPT FUNCTIONALITY:
 * > Choose input directory
 * > Save single channel as .tif
 *
 */


setBatchMode(true);

// Load files
indir = "/Users/joshtitlow/tmp/eif4e_experiment/";
print (indir);
list = getFileList(indir);


// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];
	image_name=list[i];

    // Start macro

	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	run("Arrange Channels...", "new=2");
	saveAs("Tiff", indir + substring(image_name, 0, lengthOf(image_name)-4) + "_ch2.tif");
	close();
}


setBatchMode(false);
