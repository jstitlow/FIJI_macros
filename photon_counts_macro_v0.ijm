/* Measure mean and stdev of a set of images
 * 21 June 2018
 *
 * INPUT DATASET:
 * > 10 images (single plane) with increasing intensity to cover the full dynamic range of the detector
 * 
 * 
 * SCRIPT FUNCTIONALITY: 
 * > Choose input directory with a set of images
 * > Run measure function on each image
 * > Save Results.csv to the input directory
 * 
 */


setBatchMode(true);

// Load files
indir = getDirectory("~/Desktop/test_batch");
list = getFileList(indir);

// outdir = getDirectory("~/Desktop/test_batch");

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];
		
		// Open file
		open(path);
		image = getTitle();
		// Start macro
		
		// Measure screen
		run("Measure");
		close();
}
		
saveAs("Results", indir+"Results.csv");


setBatchMode(false);