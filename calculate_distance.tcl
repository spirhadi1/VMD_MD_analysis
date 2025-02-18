###################################################################
# calculate_distance.tcl                                          #
#                                                                 #
# DESCRIPTION:                                                    #
# This script calculates the distances                            #
# between two atoms and allows users to import a                  #
# specific selection                                              #
#                                                                 # 
#                                                                 #   
# EXAMPLE USAGE:                                                  #
#         source calculate_distance.tcl                           #
#         Selection: resid 42 and chain A and name CA CB          #                    
#                                                                 #
#                                                                 #
#   S.Pirhadi                                                     #
###################################################################

# To see your selection in tkconsol:
#set sel [atomselect top "resid 42 and chain A and name CA CB"]
#For example if it outputs atomselect9, use this command to see the atomnumbers:
#atomselect9 list
#it will give 314 317 which are atom indices
#You can choose an atom on the screen with: Mouse > label > atom
#Then Graphics > labels > Picked atoms tab     you will see the atom index

#Ask user to import a specific selection
puts -nonewline "\n \t \t Selection: "
gets stdin var1
set selection [atomselect top "$var1"]

#Extract atom indexes from a specific selection
set indexes [$selection get index]

# Ensure the selection has exactly two atoms
if {[llength $indexes] != 2} {
    puts "Error: Selection must contain exactly two atoms."
    exit 1
}

# Open a file for writing the results
set output [open "$var1.distance.txt" "w"]
set n [molinfo top get numframes]

# Loop over the frames in the trajectory
for {set i 0} {$i < $n} {incr i} {
  # Set the current frame
  molinfo top set frame $i
  
  # Calculate the distance
  set dist [measure bond $indexes]
  
  puts "\t \t progress: $i/$n"

  # Write the distance value to the file
  puts $output "$dist"
}

puts "\t \t progress: $n/$n"
	
# Close the file
close $output
# Print a message
puts "\nAll done. Check $var1.distance.txt for the results.\n"
