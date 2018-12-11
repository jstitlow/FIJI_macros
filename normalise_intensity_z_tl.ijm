/* Normalise the intensity of a z-stack across a whole directory
 * 10 April 2018
 * 11 June 2018- Revised (removed SCIFIO)
 *
 * Just need to specify the channel to be normalised in two places, both look like the line below
 * run("Duplicate...", "duplicate channels=1"); // Choose channel here
 *
 * Macro commands
 *
 * Select the appropriate channel
 * Measure average intensity of each image
 * Save measurements as an array
 * Calculate stack mean from the array,
 * calculate the difference between the mean intensity of each frame and the stack mean,
 * add the difference to each frame.
 * Save the file into the original directory
 */

smFISH_channel = 1;

// Create blank array to store average intensity from the entire directory
a1=newArray;

// Duplicate stack and select specific channel
original = getTitle();
run("Duplicate...", "duplicate channels=smFISH_channel"); // Choose channel here
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

Array.getStatistics(a1,min,max,mean);
datasetMean = mean;

print("passing ave intensity of the dataset ...", datasetMean);


// Duplicate stack and select specific channel
original2 = getTitle();
run("Duplicate...", "duplicate channels=smFISH_channel"); // Choose channel here
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
      	// imageCalculator("Subtract create stack", m,detector_signal);
	}

setBatchMode(false);
