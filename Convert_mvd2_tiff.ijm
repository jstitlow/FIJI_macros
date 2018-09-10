// A macro template for batch processing multi-series images.

function processImage(path, series) {
	IJ.log("Processing " + path + "...");
	run("Bio-Formats Importer",
		"open=[" + path + "] " +
		"autoscale " +
		"color_mode=Grayscale " +
		"view=Hyperstack " +
		"stack_order=XYCZT " +
		"series_" + series);
	title = getTitle();
	title = replace(title, " ", "_");
	title = replace(title, ".", "_");
	savename = savedir + title + "-" + s + ".tif";
	saveAs("tiff", savename);
	close();
}

dir = getDirectory("Choose a Source Directory");
savedir = getDirectory("Choose a Storage Directory");
list = getFileList(dir);

setBatchMode(true);

run("Bio-Formats Macro Extensions");

for (i=0; i<list.length; i++) {
	inputPath = dir + list[i];
	if (endsWith(inputPath, ".ome.tif")) {
		// ask Bio-Formats for the number of series
		Ext.setId(inputPath);
		Ext.getSeriesCount(seriesCount);
		// process each image series individually
		for (s=0; s<seriesCount; s++) {
			processImage(inputPath, s);
		}
	}
}

setBatchMode(false);