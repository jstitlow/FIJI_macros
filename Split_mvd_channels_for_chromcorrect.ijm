/* Parse mvd files
 * 12 July 2019
 *
 *  --USAGE--
 *  Specify indir
 *  Specify outdirs
 *  Check that for loop is setup properly (normal directory or .mvd2 file)
 *  For .mvd2 file, specify
 *  Call from the command line:
 *     > fiji --headless --console -macro ~/src/FIJI_macros/Split_mvd_channels_for_chromcorrect.ijm 
 */

run("Bio-Formats Macro Extensions");
setBatchMode(true);

// load files
indir = "/usr/people/pemb4479/data/181219_smFISH_CaMKIIATTO633_nAchRa1ATTO663/";
outdir = "/usr/people/bioc1301/data/20191218_smFISH_CaMKIIATTO633_nAchRa1ATTO663/";
list = getFileList(indir);

for (k=0; k<list.length; k++) {
	if(endsWith(list[k],"..mvd2")){
	mvd2_file = "indir+k";
	print("mvd file is"+k);
	}}

// determine the number of series in the file
Ext.setId(mvd2_file);
Ext.getSeriesCount(seriesCount);
print("Series count: " + seriesCount);

// set up loop to get image files
for (i=0; i<seriesCount; i++) { // when extracting images directly from an mvd2 file
	print (i);
	run("Bio-Formats", "open=mvd2_file autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+i);
	image_name = getTitle();
	showProgress(i+1, seriesCount);
	print("processing ... "+i+1+"/"+seriesCount+"\n         "+image_name);

        // save images
        saveAs("Tiff", outdir+image_name);

        close();
        
}

setBatchMode(false);

