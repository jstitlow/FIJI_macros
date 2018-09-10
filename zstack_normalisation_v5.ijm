/* Normalise the intensity of a z-stack
 * 20 March 2018
 * 
 * Select directory of images to analyse
 * Select the appropriate channel (need to add this)
 * Measure average intensity of each image
 * Save measurements as an array
 * Calculate stack mean from the array, 
 * calculate the difference between the mean intensity of each frame and the stack mean, 
 * subtract the difference from each frame
 *
 */

// Load files
dir1 = getDirectory("/Volumes/bioc1301/data/20160929_Gal80_FISH/Files/");
list = getFileList(dir1);

setBatchMode(true);

// Set up loop to read all files in a directory
for (i=0; i<list.length; i++) {
	showProgress(i+1, list.length);
	print("processing ... "+i+1+"/"+list.length+"\n         "+list[i]);
	path=dir1+list[i];
		
		// Open file
		run("Bio-Formats", "open=path autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_");
		
		// Start macro
		a1=newArray
		
		macro "Calculate mean stack intensity" {

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
          		value=getResult("Mean ",row);
  		  		a1 = Array.concat(a1, value);  
      		}
		// Calculate average stack intensity from the array
		Array.getStatistics(a1,min,max,mean);
		print("mean is ...",mean);
		stackMean = mean;

		// Create duplicate stack to apply normalisation
		original = getTitle();
		run("Duplicate...", "duplicate");
		copy = getTitle();

			// For each slice, add difference between slice intensity and stack intensity
			for (k=1; k<=nSlices; k++) {
          		setSlice(k);
          		getStatistics(area, mean, min, max, std);
          		correctionfactor = (stackMean-mean);
          		run("Add...", "value=correctionfactor slice");
	  		}

		// Tidy up
		selectWindow(original);
		close();
		selectWindow(copy);
		run("Plot Z-axis Profile");
		selectWindow(copy);
		close();
}