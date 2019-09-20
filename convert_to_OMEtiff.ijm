// Reduce multi-channel image to single channel
// Created 2 August 2018
//
// Specify channel in line 12

setBatchMode(true);

// Load files
indir = "/Volumes/bioc1301/data/Olympus_FV3000/20190729_eIF4eGFP_Kstim_smFISH/aligned/";
list = getFileList(indir);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	if(endsWith(list[i],".dv")){
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

	// Open file
	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");

	// get image channels
	run("Arrange Channels...", "new=2");

	// save images
	run("OME-TIFF...", "save=indir+substring(list[i], 0, lengthOf(list[i])-4) + ".ome.tiff compression=Uncompressed");

	close();

	}
}

setBatchMode(false);
