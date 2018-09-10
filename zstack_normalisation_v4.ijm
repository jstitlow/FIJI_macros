a1=newArray

macro "Calculate mean stack intensity" {

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
      
//setSlice(n);
//updateResults();

Array.getStatistics(a1,min,max,mean);
print("mean is ...",mean);
stackMean = mean;
original = getTitle();
run("Duplicate...", "duplicate");
copy = getTitle();


		for (k=1; k<=nSlices; k++) {
          setSlice(k);
          getStatistics(area, mean, min, max, std);
          correctionfactor = (stackMean-mean);
          run("Add...", "value=correctionfactor slice");
	  }

selectWindow(original);
run("Plot Z-axis Profile");
selectWindow(original);
close();
selectWindow(copy);
run("Plot Z-axis Profile");
selectWindow(copy);
close();
}