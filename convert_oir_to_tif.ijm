/* Template to convert .oir files to .tif
 * 9 July 2019
 */

setBatchMode(true);

// load files
indir = "/usr/people/bioc1301/data/Olympus_FV3000/20190621_eIF4eGFP_Kstim_smFISH/oir/";
list = getFileList(indir);

// set up loop to process all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	image_name = list[i];
	path=indir+list[i];
	
	// start macro
		
	// open file
	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");

	// convert to .tif
	saveAs("Tiff", indir + substring(image_name, 0, lengthOf(image_name)-4) + ".tif");
	close();
	}

setBatchMode(false);
