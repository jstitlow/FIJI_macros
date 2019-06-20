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
