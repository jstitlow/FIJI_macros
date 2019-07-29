/*  Change properties in batch
 *
 *  --USAGE--
 *
 *   -Call from the command line:
 *   > fiji --headless --console -macro ~/src/FIJI_macros/change_properties.ijm
 *
 */

setBatchMode(true);

// setup channels and outfile
indir = "/usr/people/bioc1301/data/20190710_CaMKIIYFP_YFP647ATTO_MB112c_myrSNAP_JF546SNAP_viol/image/";
list = getFileList(indir);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

	run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");

	getDimensions(width, height, channels, slices, frames);
	run("Properties...", "channels=channels slices=slices frames=1 unit=micron pixel_width=.139 pixel_height=.139 voxel_depth=0.2000000");
	saveAs("Tiff", path);
	close();

}

setBatchMode(false);
