/* Analyse PAINT date from Nanoimager
 * 19 December 2018
 *
 *
 * Modifications to allow the code to run -headless
 *
 * Replaced Bioformats with open by enabling SCIFIO, Edit>Options>IM2>Check SCIFIO
 * Use duplicate hyperstack to crop
 * Pass indir from command line argument
 *
 * Macro commands
 *
 * Crop out the image from channel 2 on the Nanoimager
 * Run QuickPALM
 * 
 * -------KNOWN ISSUES-------
 * Gets file wrong in save, even though it is the same file as indir
 *
 * Call from the command line with the following script:
 * fiji --headless --console -macro ~/src/FIJI_macros/Nanoimager_qPALM.ijm /path/to/directory
 */

macro "PAINT_reconstruct" {

setBatchMode(true);

// Load files
//dir1 = getDirectory("Find directory");
dir1 = getArgument();
list = getFileList(dir1);


// Set up loop to read all files in a directory
for (j=0; j<list.length; j++) {
	showProgress(j+1, list.length);
	print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);
	path=dir1+list[j];

		// Open file
		#open(path);
		run("Bio-Formats (Windowless)", "open=path color_mode=Default concatenate_series group_files rois_import=[ROI manager] split_focal view=Hyperstack stack_order=XYCZT dimensions axis_1_number_of_images=2 axis_1_axis_first_image=1 axis_1_axis_increment=1 contains=[] name=/Users/joshtitlow/tmp/ONI/experiment_HiLow_Brp_Cy31.1532701055376_<1-2>.tif");
		// Start macro
		run("Concatenate...", "all_open");
		// Crop channel 2
		makeRectangle(584, 6, 427, 992);
		run("Duplicate...", "duplicate");

		// Run QuickPALM
		run("Analyse Particles", "minimum=5 maximum=4 image=106 smart online stream file=[&dir1 Table.xls] pixel=30 accumulate=0 update=10 _image=imgNNNNNNNNN.tif start=0 in=50 _minimum=0 local=20 _maximum=1000 threads=50");
		
		close();
		close();
	}

setBatchMode(false);

}
