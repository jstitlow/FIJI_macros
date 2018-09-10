/* Normalise the intensity of a z-stack
 * 26 March 2018
 * 
 * Select directory of images to analyse
 * Select the appropriate channel
 * Measure average intensity of each image
 * Save measurements as an array
 * Calculate stack mean from the array, 
 * calculate the difference between the mean intensity of each frame and the stack mean, 
 * add the difference from each frame.
 * To normalise an entire dataset, run the script and note the dataset mean intensity from the last file, 
 * then replace stackMean in line 74 with the dataset mean intensity value
 *
 */

macro "Calculate mean stack intensity" {

setBatchMode(true);

// Load files
dir1 = getArgument();
//dir1 = getDirectory("~/Desktop/test_batch");
list = getFileList(dir1);
a2=newArray;

// Set up loop to read all files in a directory
for (j=0; j<list.length; j++) {
	showProgress(j+1, list.length);
	print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);
	path=dir1+list[j];
		
		// Open file
		//run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");

		// Open file
		open(path);
		
		// Start macro
		
		// Select signal channel
		// run("Arrange Channels...", "new=1");

		// Create blank array
		a1=newArray;
		
		
			// Step through z-stack and store measurements in an array
      		if (nSlices>1) run("Clear Results");
      		getVoxelSize(w, h, d, unit);
      		n = getSliceNumber();
      		for (i=1; i<=nSlices; i++) {
          		setSlice(i);
          		getStatistics(area, mean, min, max, std);
          		row = nResults;
          		if (nSlices==1)
              		setResult("Area ("+unit+"^2)", row, area);
          		setResult("Mean ", row, mean);
          		value1=getResult("Mean ",row);
  		  		a1 = Array.concat(a1, value1);  
      		}
      		
		// Calculate average stack intensity from the array
		Array.getStatistics(a1,min,max,mean);
		stackMean = mean;
		print("stack mean intensity is ...",stackMean);
		a2 = Array.concat(a2, stackMean);
		// Array.print(a2);
		
		// Create duplicate stack to apply normalisation
		original = getTitle();
		run("Duplicate...", "duplicate");
		copy = getTitle();

			// For each slice, add difference between slice intensity and stack intensity
			for (k=1; k<=nSlices; k++) {
          		setSlice(k);
          		getStatistics(area, mean, min, max, std);
          		//correctionfactor = (stackMean-mean); 
          		print("Mean =", mean); 
          		correctionfactor = (4000-mean); 
          		run("Add...", "value=correctionfactor slice");
          		run("Measure");
	  		}

		// Tidy up
		selectWindow(original);
		close();
		selectWindow(copy);
		run("Measure");
		//saveAs("Tiff", dir1+copy);
		close();
		Array.getStatistics(a2,min,max,mean);
		datasetMean = mean;
		print("dataset mean intensity is ...",datasetMean);
	}

setBatchMode(false);
}

