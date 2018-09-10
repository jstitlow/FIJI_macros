 
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
          setResult("Std ", row, std);
          setResult("Min ", row, min);
          setResult("Max ", row, max);
          value=getResult("Mean ",row);
          //print(value);
  		  a1 = Array.concat(a1, value);
  		  
      }
      setSlice(n);
      updateResults();
      Array.print(a1);
      Array.getStatistics(a1,min,max,mean);
	  print(min);
	  print(max);
	  print(mean);
  }

 


/*
for (i=1; i<nResults; i++) {
	setSlice(i);
	getStatistics(area, mean, min, max, std);
	value=getResult("Mean",i);
  	a1 = Array.concat(a1, value);
  	{
  	Array.print(a1);
  	}

  	MeanArray=newArray("Mean");
Array.getStatistics(MeanArray,min,max,mean);
print(min);
print(max);
print(mean);:
*/