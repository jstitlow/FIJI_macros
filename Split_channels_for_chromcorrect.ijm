/* Threshold rRNA channel and save
 * 12 July 2019
 * 
<<<<<<< HEAD
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
=======
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
>>>>>>> 63e9e153150659ceba898dd0b5ead5f2ef29524c
	path=indir+list[i];
	
	// start macro
		
	// open file
<<<<<<< HEAD
	run("Bio-Formats", "open=mvd2_file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+i);
	image_name = getTitle();
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	//open(path);
=======
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	open(path);
>>>>>>> 63e9e153150659ceba898dd0b5ead5f2ef29524c
	
	// get image channels
	run("Arrange Channels...", "new=123");
	
	// save images
<<<<<<< HEAD
	saveAs("Tiff", outdir+"image/"+image_name+"tif");
	//saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");
=======
	saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");
>>>>>>> 63e9e153150659ceba898dd0b5ead5f2ef29524c

	close();
}



<<<<<<< HEAD
// set up loop to get image files
for (i=0; i<seriesCount; i++) { // when extracting images directly from an mvd2 file
//for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	//image_name = list[i];
=======
// set up loop to get cal files
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	image_name = list[i];
>>>>>>> 63e9e153150659ceba898dd0b5ead5f2ef29524c
	path=indir+list[i];
	
	// start macro
		
	// open file
<<<<<<< HEAD
	run("Bio-Formats", "open=mvd2_file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+i);
	image_name = getTitle();
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	//open(path);
	
	// get image channels
	run("Arrange Channels...", "new=123");
	
	// save images
	saveAs("Tiff", outdir+"image/"+image_name+"tif");
	//saveAs("Tiff", outdir+"image/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");
=======
	//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	open(path);

	// get image channels
	run("Arrange Channels...", "new=456");
	
	// save images
	saveAs("Tiff", outdir+"cal/"+ substring(image_name, 0, lengthOf(image_name)-8) + "tif");
>>>>>>> 63e9e153150659ceba898dd0b5ead5f2ef29524c

	close();
}

setBatchMode(false);


	
