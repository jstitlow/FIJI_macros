/* Threshold rRNA channel and save
 * 12 July 2019
 *
 *  --USAGE--
 *  Specify indir
 *  Specify outdirs
 *  Check that for loop is setup properly (normal directory or .mvd2 file)
 *  For .mvd2 file, specify
 *
 */

run("Bio-Formats Macro Extensions");
setBatchMode(true);

// load files
indir = "/usr/people/bioc1301/data/20190710_CaMKIIYFP_YFP647ATTO_MB112c_myrSNAP_JF546SNAP_viol/ometiffs/";
list = getFileList(indir);
outdir = "/usr/people/bioc1301/data/20190710_CaMKIIYFP_YFP647ATTO_MB112c_myrSNAP_JF546SNAP_viol/";
mvd2_file = "sd";

// Determine the number of series in the file (.mvd2 files only)
Ext.setId(mvd2_file);
Ext.getSeriesCount(seriesCount);
print("Series count: " + seriesCount);

// set up loop to get image files
for (i=0; i<seriesCount; i++) { // when extracting images directly from an mvd2 file
//for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	//image_name = list[i];
	path=indir+list[i];

	// start macro

	// open file
	run("Bio-Formats", "open=mvd2_file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+i);
	image_name = getTitle();
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	//open(path);

	// get image channels
	run("Arrange Channels...", "new=123");

	// save images
	saveAs("Tiff", outdir+"image/"+image_name+"tif");
	//saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");

	close();
}



// set up loop to get image files
for (i=0; i<seriesCount; i++) { // when extracting images directly from an mvd2 file
//for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	//image_name = list[i];
	path=indir+list[i];

	// start macro

	// open file
	run("Bio-Formats", "open=mvd2_file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+i);
	image_name = getTitle();
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	//open(path);

	// get image channels
	run("Arrange Channels...", "new=123");

	// save images
	saveAs("Tiff", outdir+"image/"+image_name+"tif");
	//saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");

	close();
}

setBatchMode(false);
