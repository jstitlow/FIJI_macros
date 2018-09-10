/* Script to select specific channel for FQ processing 
 *  26 March 2018
 *  Choose directory
 *  Setup tempory folder 
 *  Select channel
 *  Print info about new directory
 */

// Open Finder to choose directory
dir1 = getDirectory("/Volumes/bioc1301/data/20160929_Gal80_FISH/Files/");
list = getFileList(dir1);

// Get path to temp directory
tmp = getDirectory("temp");
if (tmp=="")
	exit("No temp directory available");

// Create a directory in temp
myDir = tmp+"my-test-dir"+File.separator;
File.makeDirectory(myDir);
if (!File.exists(myDir))
    exit("Unable to create directory");
print("");
print(myDir);
  

setBatchMode(true);

	// Set up loop to read all files in a directory
	for (i=0; i<list.length; i++) {
		showProgress(i+1, list.length);
		print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
		path=dir1+list[i];
	
		// Open file
		run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");

		// Macro starts here
		run("Arrange Channels...", "new=1");
		//run("Duplicate...", "duplicate channels=3 slices=1-69");

		saveAs("tiff", myDir+getTitle);	
		close();

	}
 	// Display info about the files
  	list = getFileList(myDir);
  	for (i=0; i<list.length; i++)
      	print(list[i]+": "+File.length(myDir+list[i])+"  "+File. dateLastModified(myDir+list[i]));	
      	
setBatchMode(false);