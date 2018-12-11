/* Subtract background from smFISH channel and save as .tiff
 * 10 December 2018
 *
 * Just need to specify the channel to be normalised
 * smFISH_channel = 1
 *
 * Uses 'rolling ball' algorithm to subtract background (radius = 8px)
 *
 * -----KNOWN ISSUES-------
 *
 * Only works for first slice in stack in command line mode
 */

macro "Calculate mean stack intensity" {

setBatchMode(true);

// Load files
//indir = getDirectory("~/Desktop/test_batch");
indir = getArgument();
list = getFileList(indir);

smFISH_channel = 1;

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=indir+list[i];

		// Open file
		open(path);

		// Start macro

		// Duplicate stack and select specific channel
    original = getTitle();
    run("Duplicate...", "duplicate channels=smFISH_channel");
    copy = getTitle();
    selectWindow(original);
    close();

    // Subtract Background
    run("Subtract Background...", "rolling=8 slice");

		// Save and close
		saveAs("Tiff", path+"_ch"+smFISH_channel);
		close();

	}

}

setBatchMode(false);
