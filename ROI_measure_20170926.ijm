/* Measure expression in NMJ from IHC
 * 19 July 2017
 * 
 * Projects average of z series
 * Selects the appropriate channel
 * Makes measurements from 3 ROIs (5um x 5um)
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
		
		// Retrieve ROIs 
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0387-1139.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0427-1139.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0463-1145.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0505-1151.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0541-1153.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0579-0639.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0611-0639.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0729-0645.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0761-0645.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0917-0651.roi");
		roiManager("Open", "/Users/joshtitlow/src/FIJI_Macros/ROIs/RoiSet/0957-0631.roi");
		
		// Project average intensity from the Z stack
		run("Z Project...", "projection=[Max Intensity]");
		
		// Select signal channel
		//run("Arrange Channels...", "new=2");

		// Subtract background flourescence intensity
		run("Subtract...", "value=515");

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
		roiManager("Select", 10);
		run("Measure");
		close();
		close();
	
}
setBatchMode(false);
