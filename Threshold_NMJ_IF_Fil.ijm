/* Measure expression in NMJ from IHC
 * 8 May 2017
 * 
 * Projects average of z series
 * Selects the appropriate channel
 * Makes measurements from 3 boxes (5um x 5um)
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
		
		// Select signal and marker channels 
		run("Z Project...", "projection=[Average Intensity]");
		run("Arrange Channels...", "new=3");
		roiManager("Select", 0);
		run("Measure");
		roiManager("Select", 1);
		run("Measure");
		roiManager("Select", 2);
		run("Measure");
		close();
		close();
	
}
setBatchMode(false);
