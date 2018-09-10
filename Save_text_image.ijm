/* Generate text images from a folder full of image files
 * 5 January 2018
 * 
 * Select folder containing images
 * Projects max intensity projection of z series
 * Selects the appropriate channel (user specified)
 * Saves the image as text image
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
		
		
		// Project max intensity from the Z stack
		run("Z Project...", "projection=[Max Intensity]");
		
		// Select signal channel
		run("Arrange Channels...", "new=1");

		saveAs("Text Image", path);
		close();
		close();

}
setBatchMode(false);