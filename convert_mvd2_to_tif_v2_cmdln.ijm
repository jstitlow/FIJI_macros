/* Template to extract individual image series from .mvd2 files and save them as .tifs
 * 5 March 2018
 * 11 July 2018- revised
 */

run("Bio-Formats Macro Extensions");
setBatchMode(true);

// Select .mvd file
id = getArgument();
print("Image path: " + id);

// Select output directory
// savedir = getDirectory("Choose a Storage Directory");

// Determine the number of series in the file
Ext.setId(id);
Ext.getSeriesCount(seriesCount);
print("Series count: " + seriesCount);

// Process each image series individually
	for (s=0; s<seriesCount; s++) {
		showProgress(s+1, seriesCount);
		print("processing ... " + "series" +s);

		// Open file
		run("Bio-Formats", "open=id autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT use_virtual_stack series_"+s);
		savename = getTitle();
		saveAs("Tiff", savename);
		close();
	}

setBatchMode(false);
