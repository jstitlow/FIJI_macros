/* Remove background and isolate single channel for downstream FQ analysis
 * 18 January 2019
 *
 * Uses 'rolling ball' background subtraction algorithm
 *
 * ---Modifications to allow the code to run -headless---
 *
 * -Replaced Bioformats with open by enabling SCIFIO, Edit>Options>IM2>Check SCIFIO
 * -Duplicate hyperstack instead of arrange channels
 * -Pass directory from command line argument instead of calling finder window
 *
 * ---Macro commands---
 *
 * Setup directories
 * Select the appropriate channel
 * Subtract background
 * Save single channel image
 * 
 * ----Call from the command line with the following script:
 * fiji --headless --console -macro ~/src/FIJI_macros/subtract_background_cmndln.ijm /path/to/directory
 *
 * ---requires absolute path---
 */

macro "Subtract_background" {

setBatchMode(true);

// Setup directories
indir = getArgument();
list = getFileList(indir);

GFP_channel = ('2');
smFISH_channel = ('3');

File.makeDirectory(indir+'GFP_channel');
File.makeDirectory(indir+'smFISH_channel');

GFP_dir = indir+'GFP_channel/';
smFISH_dir = indir+'smFISH_channel/';

// Setup loop
for (j=0; j<list.length; j++) {
        showProgress(j+1, list.length);
        filename = indir + list[j];
        if (endsWith(filename, ".tiff"))
        print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);

        // Open file
        if (endsWith(filename, ".tiff"))
        open(filename);

        // Start macro

        // Duplicate stack and select specific channel
        original = getTitle();
        run("Duplicate...", "duplicate channels=GFP_channel");
        GFP = getTitle();

        selectWindow(original);
        run("Duplicate...", "duplicate channels=smFISH_channel");
        smFISH = getTitle();

        selectWindow(original);
        close();

	// Subtract background
        selectWindow(GFP);
        run("Subtract Background...", "rolling=8 stack");
        GFP_file = replace(GFP, "-1.tiff", "_GFP.tiff");
        saveAs("Tiff", GFP_dir+GFP_file);
        close();

        selectWindow(smFISH);
        run("Subtract Background...", "rolling=8 stack");
        smFISH_file = replace(smFISH, "-1.tiff", "_smFISH.tiff");
        saveAs("Tiff", smFISH_dir+smFISH_file);
        close();

}

setBatchMode(false);
}
