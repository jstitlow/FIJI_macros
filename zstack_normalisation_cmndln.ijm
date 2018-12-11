/* Normalise the intensity of a z-stack
 * 11 December 2018
 *
 * Modifications to allow it to run -headless
 *
 * Replaced Bioformats with open by enabling SCIFIO, Edit>Options>IM2>Check SCIFIO
 * Also use duplicate hyperstack instead of arrange channels
 * Pass directory from command line argument instead of calling finder window
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
 * Call from the command line with the following script:
 * fiji --headless --console -macro ~/src/FIJI_macros/zstack_normalisation_v7_cmndln.ijm /path/to/directory
 */

macro "Calculate mean stack intensity" {

setBatchMode(true);

// Load files
//dir1 = getDirectory("Find directory");
dir1 = getArgument();
list = getFileList(dir1);
smFISH_channel = 1
// Create blank array to store average intensity from the entire directory
a2=newArray;

// Set up loop to read all files in a directory
for (j=0; j<list.length; j++) {
	showProgress(j+1, list.length);
	print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);
	path=dir1+list[j];

		// Open file
		open(path);

		// Start macro

		// Duplicate and select specific channel
		original = getTitle();
		run("Duplicate...", "duplicate channels=smFISH_channel");
		copy = getTitle();
		selectWindow(original);
		close();

		// Create blank array to store average intensity from each z-stack
		a1=newArray;


		// Step through z-stack and store average intensity measurements in an array
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

		// Tidy up
		selectWindow(copy);
		//saveAs("Tiff", dir1+copy);
		//run("Measure");
		close();
		Array.getStatistics(a2,min,max,mean);
		datasetMean = mean;
		print("dataset mean intensity is ...",datasetMean);
	}

  print("passing ave intensity of the dataset ...", datasetMean);

// Apply normalisation *******************************************************************************

// Loop through directory again
for (k=0; k<list.length; k++) {
	showProgress(k+1, list.length);
	print("processing ... "+k+1+"/"+list.length+"\n         "+list[k]);
	path=dir1+list[k];

    // Open file
    open(path);

		// Start macro

		// Duplicate stack and select specific channel
		original2 = getTitle();
		run("Duplicate...", "duplicate channels=smFISH_channel"); // Choose channel here
		copy2 = getTitle();
		selectWindow(original2);
		close();
		selectWindow(copy2);

    // Step through z-stack and store average intensity measurements in an array
      		if (nSlices>1) run("Clear Results");
      		getVoxelSize(w, h, d, unit);
      		n = getSliceNumber();
      		for (i=1; i<=nSlices; i++) {
          		setSlice(i);
          		getStatistics(area, mean, min, max, std);
              correctionfactor = (datasetMean-mean);
              run("Subtract Background...", "rolling=8 slice");
          		row = nResults;
          		if (nSlices==1)
              		setResult("Area ("+unit+"^2)", row, area);
          		setResult("Mean ", row, mean);
          		value1=getResult("Mean ",row);
  		  		a1 = Array.concat(a1, value1);
      		}

      // Tidy up
  		selectWindow(copy2);
  		saveAs("Tiff", dir1+copy2);
  		close();

	  	}

	}

setBatchMode(false);

}
