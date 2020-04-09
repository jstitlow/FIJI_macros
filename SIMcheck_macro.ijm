/* Segmentation script to measure signal intensity within marker
 *   26 June 2019
 *
 *  -Measures intensity from  a masked image (10 slices (~2um) volume) in the center of a z-stack
 *  -Records volume of the mask (_mask_vol RawIntDen)
 *
 *  --IMAGE PROCESSING--
 *
 *   -Normalise z intensity with 'Bleach Correction' algorithm
 *   -Sharpen and flatten field with 'Subtract Background' algorithm
 *
 *  --USAGE--
 *   -check that channels are setup properly
 *   -call from the command line:
 *     > fiji --headless --console -macro ~/src/FIJI_macros/SIMcheck_macro.ijm /path/to/data/ | tee log.txt
 *
 */

//run("ImageJ2...", "scijavaio=true loglevel=INFO");

setBatchMode(true);

indir = getArgument();
//indir = "z:\\2019100304_AO_testing\\";
list = getFileList(indir);

for (i=0; i<list.length; i++) {
    //if(endsWith(list[i],".r3d")){
    	showProgress(i+1, list.length);
    	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
    	path=indir+list[i];

    	// Open file
    	open(path);
    	//run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");
 	run("Modulation Contrast", "angles=3 phases=5 z_window_half-width=1");
    }


setBatchMode(false);

