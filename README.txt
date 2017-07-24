graphdigitizer is a MATLAB function for converting graphs in .jpg, .png and .gif picture formats into numerical format. For instructions in its use, run the function as graphdigitizer() and press the 'help' button, or read the 'help.txt' file in the 'help' folder. This program is currently functional but is still under development and will be improved in the future.

Requirements: Tested on Matlab R2017a, may or may not work on older versions, needs at least Matlab R2014b. 

TO DO:
This is a list of features that should be made available in upcoming
versions of this program. Also includes a list of known bugs.

 PRIORITY I
  - make sure new changes work with different screen sizes
  - make 'test' button invisible when no longer needed

 PRIORITY II
 - 'are you sure?' -question before refreshing the graph and overwriting all user-made changes
 - create algorithm to reduce static in the graph
 - improve the functionality of distance parameter

PRIORITY III
 - adjustable range for data point deletion
 - set index value edit field maximum values depending on size of picture and scale mode
 - indicate which mode is active
 - add button to cancel active mode at any time
 - functionality to remove all data points within a specified distance of the edges of the picture
 - option to specify save file data format and headers
 - expand the help GUI
 - add parameters for total score tolerance and finding the middle of a thick line
