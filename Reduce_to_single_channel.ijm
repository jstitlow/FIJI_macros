// Reduce multi-channel image to single channel
// Created 2 August 2018
//
// Specify channel in line 12

setBatchMode(true);

// Load files
indir = "/Users/joshtitlow/OneDrive - Nexus365/SypPaper/Data/FINAL/coloc_analysis/20190621_eIF4eGFP_msp670_syp568_HRP_viol/mock/";
list = getFileList(indir);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	if(endsWith(list[i],".tif")){
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];
		
	// Open file
	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		
	// get image channels
	run("Arrange Channels...", "new=2");
	
	// save images
	saveAs("Tiff", indir+substring(list[i], 0, lengthOf(list[i])-3) + "-2.tif");

	close();
	
	}
}

setBatchMode(false);

		