/* Measure expression in NMJ from IHC
 * 19 July 2017
 * revised: 4 December 2017
 * 
 * Select folder containing ROIs
 * Selects folder containing images
 * Projects max of z series
 * Subtracts background (user specified)
 * Selects the appropriate channel (user specified)
 * Makes measurements from 10 ROIs (5um x 5um; user inputs directory of ROIs)
 */


// Retrieve ROIs   
  macro "Open All" {
      dir = getDirectory("Choose a Directory ");
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], ".roi"))
              roiManager("open", dir+list[i]);
      }

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
		//run("Arrange Channels...", "new=1");

		// Subtract background flourescence intensity
		run("Subtract...", "value=1800");

		// Take measurements from each of the ROIs
		roiManager("Select", 0);
		run("Measure");
		roiManager("Select", 1);
		run("Measure");
		roiManager("Select", 2);
		run("Measure");
		roiManager("Select", 3);
		run("Measure");
		roiManager("Select", 4);
		run("Measure");
		roiManager("Select", 5);
		run("Measure");
		roiManager("Select", 6);
		run("Measure");
		roiManager("Select", 7);
		run("Measure");
		roiManager("Select", 8);
		run("Measure");
		roiManager("Select", 9);
		run("Measure");
		close();
		close();
	
}
setBatchMode(false);
