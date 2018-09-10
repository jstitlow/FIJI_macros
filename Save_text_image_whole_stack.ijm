/* Generate text images from a folder full of image files
 * 1 March 2018
 * 
 * Select folder containing images
 * Selects the appropriate channel (user specified)
 * Apply threshold to the middle image
 * Save each slice as text image
 */



 // Load files
dir1 = getDirectory("/Volumes/bioc1301/data/20160929_Gal80_FISH/Files/");
list = getFileList(dir1);

setBatchMode(true);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=dir1+list[i];
	
		// Open file
		run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");

	
		// Insert Macro here

		// Select nuclei channel
		title = getTitle();
		run("Arrange Channels...", "new=3");

		// Create binary mask

		// Go to middle of the stack
		middleslice=floor(nSlices/2);
		setSlice(middleslice);

		// Apply threshold 
		setAutoThreshold("Huang dark");
		run("Convert to Mask", "method=Huang background=Dark");
		run("Divide...", "value=255 stack");
		
		// Save as text file for every z plane
		// slicenumber = nSlices
		
		for (k=1; k<=nSlices; k++){ 
 			setSlice(k); 
			saveAs("Text Image",path+k);
			//run("Measure");
		}
		close;
}
setBatchMode(false);