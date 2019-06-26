/* Merge .tiffs from Nanoimager and crop
 * 2 January 2019
 *
 * ------- Macro commands -------
 *
 * Get file from command line argument
 * Open the entire file series using Bioformats
 * Crop ch2
 *
 * ------- KNOWN ISSUES -------
 *
 * -Add _0 to first filename
 * -Ext.getSeriesCount does not calculate the number of files in the series
 *     -not a big deal since most of the series are the same length
 *
 * ------- Modifications to run -headless -------
 *
 * Call bioformats in windowless mode: "Bio-Formats Windowless Importer"
 *
 *
 * Call macro the command line with the following script:
 * fiji --headless --console -macro ~/src/FIJI_macros/Nanoimager_merge.ijm /path/to/directory
 */


macro "PAINT_reconstruct" {

setBatchMode(true);

// Load file
infile = getArgument();
print(infile);
//infile = "/usr/people/bioc1301/data/NanoImager/DEFAULT_USER/20181221_20181221_GATTAquant/20181221_GATTAquant_LP_25.1545402438719_0.tif";
infile_series = replace(infile,"_0.tif","<0-9>.tif");
outfile = replace(infile, "_0.tif", "_crop.raw");

//run("Bio-Formats Macro Extensions");
// Ext.setId(infile);
// Ext.getSeriesCount(seriesCount);
// print("Series count: " + seriesCount);

//Ext.openImagePlus(nd2File);
// Open file
run("Bio-Formats", "open=infile color_mode=Default crop group_files rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT dimensions axis_1_number_of_images=10 axis_1_axis_first_image=0 axis_1_axis_increment=1 contains=[] name=infile_series x_coordinate_1=610 y_coordinate_1=0 width_1=412 height_1=1024");
//run("Bio-Formats (Windowless)", "open=infile");
//saveAs("Tiff", outfile);
saveAs("Raw Data", outfile);

setBatchMode(false);

}
