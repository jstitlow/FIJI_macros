/* Normalise the intensity of a z-stack
 * 10 April 2018
 * 
 * Modifications to allow it to run -headless
 * 
 * Replaced Bioformats with open by enabling SCIFIO, Edit>Options>IM2>Check SCIFIO
 * Also use duplicate hyperstack instead of arrange channels
 * Pass directory from command line argument instead of calling finder window
 * Still doesn't work, doesn't apply correction factor
 * 
 * Macro commands
 * 
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
indir = getDirectory("~/Desktop/test_batch");
list = getFileList(indir);

// Create blank array to store average intensity from the entire directory
a1=newArray;

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
		run("Duplicate...", "duplicate channels=1");
		copy = getTitle();
		selectWindow(original);
		close();
		
		// Create blank array to store average intensity from each z-stack
		a2=newArray;
		
			// Step through z-stack and store average intensity measurements in an array
      		if (nSlices>1) run("Clear Results");
      		getVoxelSize(w, h, d, unit);
      		n = getSliceNumber();
      		for (j=1; j<=nSlices; j++) {
          		setSlice(j);
          		getStatistics(area, mean, min, max, std);
          		row = nResults;
          		if (nSlices==1)
              		setResult("Area ("+unit+"^2)", row, area);
          		setResult("Mean ", row, mean);
          		value1=getResult("Mean ",row);
  		  		a2 = Array.concat(a2, value1);  
      		}
      		
		// Calculate average stack intensity from the array
		Array.getStatistics(a2,min,max,mean);
		stackMean = mean;
		print("stack mean intensity is ...",stackMean);
		a1 = Array.concat(a1, stackMean);

		// Tidy up
		selectWindow(copy);
		close();
		Array.getStatistics(a1,min,max,mean);
		datasetMean = mean;
	}
	
print("passing ave intensity of the dataset ...", datasetMean);

// Apply normalisation *******************************************************************************

// Loop through directory again
for (k=0; k<list.length; k++) {
	showProgress(k+1, list.length);
	print("processing ... "+k+1+"/"+list.length+"\n         "+list[k]);
	path=indir+list[k];
		
		// Open file
		open(path);
				
		// Start macro
		
		// Duplicate stack and select specific channel
		original2 = getTitle();
		run("Duplicate...", "duplicate channels=1");
		copy2 = getTitle();
		selectWindow(original2);
		close();
		selectWindow(copy2);
		
		// For each slice, add difference between slice intensity and stack intensity
		for (m=1; m<=nSlices; m++) {
          	setSlice(m);
          	getStatistics(area, mean, min, max, std);  
          	correctionfactor = (datasetMean-mean); 
          	run("Add...", "value=correctionfactor slice");
	  	}

		// Tidy up
		selectWindow(copy2);
		saveAs("Tiff", indir+copy2);
		close();

	}

}

setBatchMode(false);