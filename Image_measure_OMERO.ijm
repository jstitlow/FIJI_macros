/* Measure expression in NMJ from IHC
 * 19 July 2017
 * created: 31 January 2018
 * 
 * Selects folder containing images
 * Creates average intensity projection of z series
 * Subtracts background (user specified)
 * Selects the appropriate channel (user specified)
 * Measures from 10 ROIs intensity of the entire image
 */


		// Project average intensity from the Z stack
		run("Z Project...", "projection=[Average Intensity]");
		
		// Select signal channel
		run("Arrange Channels...", "new=4");

		// Subtract background flourescence intensity
		//run("Subtract...", "value=1800");

		// Measure intensity of the entire image
		run("Measure");
		close();
		close();
	
}
setBatchMode(false);
