graphdigitizer is a MATLAB function for converting graphs in .jpg, .png and .gif picture formats into numerical format. For instructions in its use, run the function as graphdigitizer() and press the 'help' button, or read the 'help.txt' file in the 'help' folder. This program is currently functional but is still under development and will be improved in the future.

TO DO:
This is a list of features that should be made available in upcoming
versions of this program. Also includes a list of known bugs.

 PRIORITY I
 - switch wasd key activity to arrow keys or otherwise prevent unwanted writing in edit fields while zooming

 PRIORITY II
 - delete several data points by pressing down mouse button 1 and moving the mouse over them 
 - 'are you sure?' -question before refreshing the graph and overwriting all user-made changes
 - forbid wasd key activity when an edit field is active
 - create algorithm to reduce static in the graph
 - improve graph-finding algorithm (done, just needs testing and refactoring)

PRIORITY III
 - set index value edit field maximum values depending on size of picture and scale mode
 - improve the behavior of the parameters
 - indicate which mode is active
 - functionality to remove all data points within a specified distance of the edges of the picture
 - check the validity of output file name
 - option to specify save file data format and headers
 - expand the help GUI