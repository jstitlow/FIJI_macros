macro "Calculate mean stack intensity" {

setBatchMode(true);

// Setup directories
indir = getArgument();
list = getFileList(indir);

GFP_channel = ('2');
smFISH_channel = ('3');

File.makeDirectory(indir+'GFP_channel');
File.makeDirectory(indir+'smFISH_channel');

GFP_dir = indir+'GFP_channel/';
print (GFP_dir);
smFISH_dir = indir+'smFISH_channel/';

// Setup loop
for (j=0; j<list.length; j++) {
	showProgress(j+1, list.length);
	//path=indir+list[j];
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

// Setup loop
for (j=0; j<list.length; j++) {
        showProgress(j+1, list.length);
        //path=indir+list[j];
        filename = indir + list[j];
        if (endsWith(filename, ".tiff"))
        print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);
}
