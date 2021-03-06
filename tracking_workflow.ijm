/* Single molecule tracking workflow
 * 19 June 2019
 *
 * INPUT IMAGES:
 * > Directory of 3D time series images
 * > PSF
 * 
 * SCRIPT FUNCTIONALITY: 
 * > Choose input directory with a set of images
 * > Correct for bleaching
 * > Deconvolve w/DeconvolvulationLab
 * > Track with trackmate
 * 
 * USAGE:
 * > fiji --headless -macro ~/src/FIJI_macros/tracking_workflow.ijm
 */


setBatchMode(true);

// Load files
indir = "/usr/people/bioc1301/data/20190529_sggMS2_MCPGFP_stim/rawdata/";
// indir = getDirectory("Select a directory");
list = getFileList(indir);

// psf_file = File.openDialog("Select a PSF file");
psf_file = "/usr/people/bioc1301/data/20190529_sggMS2_MCPGFP_stim/PSF_3D.tif";

// Set up loop to process all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];
		
		// Start macro
		
		// Open file
		//run("Bio-Formats", "open=path color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
		open(path);
		image_name = getTitle();
		

		// Generate max projection
		run("Z Project...", "projection=[Max Intensity] all");
		max_projection = getTitle();

		
		// Run bleach correction
		run("Bleach Correction", "correction=[Exponential Fit]");
		close(max_projection);
		bleach_correct = getTitle();
		selectWindow(bleach_correct);
		
		// Decoconvolve
		// image = " -image platform active";
		image = " -image file " + path;
		print (image);
		// psf = " -psf file /Users/joshtitlow/tmp/MS2/20190529_sggMS2MCPGFP_d42_Kstim/PSF_2D.tif";
		psf = " -psf file " + psf_file;
		algorithm = " -algorithm RL 30";
		parameters = "";
		parameters += " -out stack noshow " + substring(image_name, 0, lengthOf(image_name)-4) + "_decon";
		parameters += " -path " + indir;
		parameters += " -monitor no";
		outfile = indir + substring(image_name, 0, lengthOf(image_name)-4) + "_decon.tif";
		run("DeconvolutionLab2 Run", image + psf + algorithm + parameters);
		close(bleach_correct);

		// wait for the first deconvolution to finish
		while (!File.exists(outfile)) {
		}

}
setBatchMode(false);

	
	
	
	
