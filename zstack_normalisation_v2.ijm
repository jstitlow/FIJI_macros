/* Measure expression in NMJ from IHC
 * 8 May 2017
 * 
 * Projects average of z series
 * Selects the appropriate channel
 * Makes measurements from 3 boxes (5um x 5um)
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
		
a1=newArray
macro "Show Statistics" {
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
      setSlice(n);
      updateResults();
      Array.getStatistics(a1,min,max,mean);
	  print("mean is ...",mean);
  }

