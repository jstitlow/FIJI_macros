// Run from command line 
// /Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --headless --console -macro Path/to/macro.ijm "arg0 arg1"

args = split(getArgument()," "); 
        print(args[0]);
        print(args[1]);