/* Get channels from each file in a dataset
 * 1 August 2018
 *
 * INPUT DATASET:
 * > any image file
 *
 *
 * SCRIPT FUNCTIONALITY:
 * > Choose input directory with a set of images
 * > Print number of channels
 *
 */


setBatchMode(true);

// Load files
indir = getDirectory("~/Desktop/test_batch");
list = getFileList(indir);

print("Get Dimensions");

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

    // Start macro

		// Open file
		run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		image = getTitle();

		// Measure screen
		getDimensions(w, h, channels, slices, frames);
		Stack.getPosition(channel, slice, frame);
    print("   Channels: "+channels);
    close();
}


setBatchMode(false);
