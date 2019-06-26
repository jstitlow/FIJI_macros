file = '/usr/people/bioc1301/tmp/smFISH_data/20171013_CS_2colorsmFISH_msp670_570_DAPI_HRP405_p1s3r.ome.tiff';
open (file);
close;
print ('file is closed');
// Setup directories
indir = getArgument();
list = getFileList(indir);

GFP_channel = ('2');
smFISH_channel = ('3');


// Setup loop
for (j=0; j<list.length; j++) {
        showProgress(j+1, list.length);
        //path=indir+list[j];
        filename = indir + list[j];
        if (endsWith(filename, ".tiff"))
        print("processing ... "+j+1+"/"+list.length+"\n         "+list[j]);
}
