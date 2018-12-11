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

macro "Calculate mean stack intensity" {

setBatchMode(true);

// Load files
//indir = getDirectory("~/Desktop/test_batch");
indir = getArgument();
list = getFileList(indir);

smFISH_channel = 1;

// Load file for detector background subtraction
// function is in line 117
//open("~Desktop/test/20180627_dark_counts.ome.tiff");
//selectWindow(detect);
//run("Z Project...", "projection=[Average Intensity]");
//selectWindow();
//detector_signal = "20180627_dark_counts.ome.tiff");

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
		run("Duplicate...", "duplicate channels=smFISH_channel"); // Choose channel here
		copy2 = getTitle();
		selectWindow(original2);
		close();
		selectWindow(copy2);

    // Create blank array to store average intensity from each z-stack
		a3=newArray;

		// For each slice, add difference between slice intensity and stack intensity
		for (m=1; m<=nSlices; m++) {
          	setSlice(m);
          	getStatistics(area, mean, min, max, std);
            print ("dataset mean =", datasetMean);
          	addition = (datasetMean-mean);
            print ("correction factor =", addition);
            print (mean, "before");
            //print ("adding correction factor =", addition);
          	run("Add...", "value=addition slice");
            //run("Subtract Background...", "rolling=50 slice");
            getStatistics(area, mean, min, max, std);
            print (mean, "after");
            row = nResults;
            if (nSlices==1)
                setResult("Area ("+unit+"^2)", row, area);
            setResult("Mean ", row, mean);
            value1=getResult("Mean ",row);
          a3 = Array.concat(a3, value1);
          	// imageCalculator("Subtract create stack", m,detector_signal);

      }

      // Calculate average stack intensity from the array
  		Array.getStatistics(a3,min,max,mean);
  		stackMean = mean;
  		print("stack mean intensity is ...",stackMean);


		// Tidy up
		selectWindow(copy2);
		//saveAs("Tiff", indir+copy2);
		close();

	}

}

setBatchMode(false);
