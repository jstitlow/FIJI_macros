/* Template to extract individual image series from .mvd2 files and save them as .tifs
 * 28 February 2020
 * --USAGE---
 * fiji --headless --console -macro ~/src/FIJI_macros/convert_mvd2_to_tif.ijm
 */

run("Bio-Formats Macro Extensions");
setBatchMode(true);

// Select .mvd file
//id = File.openDialog("Choose a file");
id = "/usr/people/pemb4479/data/060320\ smFISH\ MBONs/060320 smFISH MBONs.mvd2";
print("Image path: " + id);

// Select output directory
//savedir = getDirectory("Choose a Storage Directory");
savedir = "/usr/people/bioc1301/data/AdultBrain_smFISH_MASTER/20200306_smFISH_MBONs/";

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
		title = getTitle();
		savename = savedir + substring(title, 27) + ".ome.tiff";
		print (savename);
		//saveAs("Tiff", savename);
		run("OME-TIFF...", "save=" + savename + " export compression=Uncompressed");
		close();
	}

setBatchMode(false);
