graphdigitizer is a MATLAB function for converting graphs in .jpg, .png and .gif picture formats into numerical format. For instructions in its use, run the function as graphdigitizer() and press the 'help' button, or read the 'help.txt' file in the 'help' folder. This program is currently functional but is still under development and will be improved in the future.

Requirements: Tested on Matlab R2017a, may or may not work on older versions, needs at least Matlab R2014b. 

TO DO:
This is a list of features that should be made available in upcoming
versions of this program. Also includes a list of known bugs.

 PRIORITY I
  - improve the behavior of the parameters (update parameters and their descriptions to match the new graph-finding algorithm)

 PRIORITY II
 - delete several data points by pressing down mouse button 1 and moving the mouse over them 
 - 'are you sure?' -question before refreshing the graph and overwriting all user-made changes
 - forbid wasd key activity when an edit field is active
 - create algorithm to reduce static in the graph
 - improve graph-finding algorithm (done, just needs testing and refactoring)

PRIORITY III
 - set index value edit field maximum values depending on size of picture and scale mode
 - indicate which mode is active
 - functionality to remove all data points within a specified distance of the edges of the picture
 - check the validity of output file name
 - option to specify save file data format and headers
 - expand the help GUI
