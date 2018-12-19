/* Generate text images from a folder full of image files
 * 14 December 2018
 * 
 * Select folder containing images
 * Selects the appropriate channels (user specified)
 * Select middle slice of the stack
 * Save the slice as a text image
 */



 // Load files
dir1 = getDirectory("/Volumes/bioc1301/data/20160929_Gal80_FISH/Files/");
list = getFileList(dir1);

// Define channel
smFISH_channel1 = 1
smFISH_channel2 = 2

setBatchMode(true);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=dir1+list[i];
	
		// Open file
		run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");

		// Insert Macro here

		// Crop edges (for deconvolved Airyscan data)
		makeRectangle(13, 15, 922, 926);
		run("Crop");

		// Duplicate and select specific channel
		original = getTitle();
		run("Duplicate...", "duplicate channels=smFISH_channel1");
		ch1 = getTitle();
		selectWindow(original);
		run("Duplicate...", "duplicate channels=smFISH_channel2");
		ch2 = getTitle();
		selectWindow(original);
		close();
		
		selectWindow(ch1);
 		setSlice(nSlices/2); 
 		print(dir1+"ch1_"+list[i]);
		saveAs("Text Image", dir1+"ch1_"+list[i]);
		close();

		selectWindow(ch2);
 		setSlice(nSlices/2); 
 		print(dir1+"ch2_"+list[i]);
		saveAs("Text Image", dir1+"ch2_"+list[i]);
 		close();
}

setBatchMode(false);