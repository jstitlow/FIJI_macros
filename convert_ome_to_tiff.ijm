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
		
		title1 = getTitle();
		run("Split Channels");
		Ch1 = "C1-" + title1; 
		Ch2 = "C2-" + title1;

		// Make sure variables aren't screwed up
		//print(c1Title);
		//print(c2Title);

		selectWindow(Ch2);
		close();
		selectWindow(Ch1);
		saveAs("Tiff", path);
		close();
	
}
setBatchMode(false);
