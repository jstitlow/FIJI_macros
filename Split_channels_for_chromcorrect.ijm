/* Threshold rRNA channel and save
 * 12 July 2019
 * 
 *  Requires directory of images called ometiffs
 *  Requires outdirs called cal and imageCalculator(operator, img1, img2)
 *  s
 */

setBatchMode(true);

// load files
indir = "/usr/people/bioc1301/data/20190710_CaMKIIYFP_YFP647ATTO_MB112c_myrSNAP_JF546SNAP_viol/ometiffs/";
list = getFileList(indir);
outdir = "/usr/people/bioc1301/data/20190710_CaMKIIYFP_YFP647ATTO_MB112c_myrSNAP_JF546SNAP_viol/"


// set up loop to get image files
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	image_name = list[i];
	path=indir+list[i];
	
	// start macro
		
	// open file
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	open(path);
	
	// get image channels
	run("Arrange Channels...", "new=123");
	
	// save images
	saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");

	close();
}



// set up loop to get cal files
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	image_name = list[i];
	path=indir+list[i];
	
	// start macro
		
	// open file
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	open(path);

	// get image channels
	run("Arrange Channels...", "new=456");
	
	// save images
	saveAs("Tiff", outdir+"cal/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");

	close();
}

setBatchMode(false);


	
