// Reduce multi-channel image to single channel
// Created 2 August 2018
//
// Specify channel in line 12

setBatchMode(true);

// Load files
indir = "/usr/people/bioc1301/data/20171026_YFP_smFISH_MB077c_SNAP_AdultBrain/";
list = getFileList(indir);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	if(endsWith(list[i],".tiff")){
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

	// Open file
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	open(path);

	// save images
	outfile = indir+"decon/"+substring(list[i], 0, lengthOf(list[i])-5)+".ome.tiff";
	print(outfile);
	run("OME-TIFF...", "save=" + outfile);

	close();

	}
}

setBatchMode(false);
