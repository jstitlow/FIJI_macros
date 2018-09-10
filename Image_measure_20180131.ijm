/* Measure expression in NMJ from IHC
 * 19 July 2017
 * created: 31 January 2018
 * 
 * Selects folder containing images
 * Creates average intensity projection of z series
 * Subtracts background (user specified)
 * Selects the appropriate channel (user specified)
 * Measures from 10 ROIs intensity of the entire image
 */


 // Select directory and load files
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
		
		
		// Project average intensity from the Z stack
		run("Z Project...", "projection=[Average Intensity]");
		
		// Select signal channel
		run("Arrange Channels...", "new=2");

		// Subtract background flourescence intensity
		//run("Subtract...", "value=1800");

		// Measure intensity of the entire image
		run("Measure");
		close();
		close();
	
}
setBatchMode(false);
