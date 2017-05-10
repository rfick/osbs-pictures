How to run the Graphical User Interface (GUI) for assigning abundances of materials in frames from OSBS.

__________________
Do this the first time

Step 1.  Download the osbs-pictures directory from github, and put the directory osbs-pictures and all subdirectories on the MATLAB path.
One way to do that is to run pathtool from the MATLAB command line. A window will open containing all the directories on your path.
Click on Add with Subfolders…
Navigate the file system so you select the directory osbs-pictures and click Open.
osbs-pictures and the subdirectory should show up in your path.

Step 2.  Run 

guide 

from the MATLAB command line.

Step 3.  Select

Sliders.fig

from the GUI.

Step 4. Click on the green arrow and the first image should appear with a blue grid overlaid on top of it.

Step 5. Type your first and last name into the text boxes above the image (If you don’t, it will crash because it won’t be able to find the result file with your name on it).

Do Until Done:

   Step 6.  Fill in the text boxes with the percentage of each material inside the frame.

   Step 7.  Click on Submit.

   Step 8.  Click on Next.

End Do

When you are finished, just close the window

_______________________________

You should be able to stop and restart the program and it will start at the last image you were looking at, AS LONG AS YOU DON’T CHANGE ANY OF THE FILES IN THE DIRECTORY (they keep track of where you are).  Just run “guide” again and click on the green arrow.  Then you can resume steps 5,6, and 7 above.


