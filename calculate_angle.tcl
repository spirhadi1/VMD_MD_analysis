
###################################################################
# calculate_angle.tcl                                             #
#                                                                 #
# DESCRIPTION:                                                    #
# This script calcultes the angles                                #
# between three atoms and allows users to import a                #
# specific selection                                              #
#                                                                 # 
#                                                                 #   
# EXAMPLE USAGE:                                                  #
#         source calculate_angle.tcl                              #
#         Selection: resid 42 and chain A and name CA CB CG       #                    
#                                                                 #
#                                                                 #
# Jan 18, 2023, Schiffer Lab                                      #
###################################################################

# To see your selection in tkconsol:
#set sel [atomselect top "resid 42 and chain A and name CA CB CG"]
#For example if it outputs atomselect9, use this command to see the atomnumbers:
#atomselect9 list
#it will give 314 317 318 which are atom index
#You can choose an atom on the screen with: Mouse > lable > atom
#Then Graphics > labels > Picked atoms tab     you will see the atom index

#Ask user to import an specific selection
puts -nonewline "\n \t \t Selection: "
gets stdin var1
set selection [atomselect top "$var1"]

#Extract atom indexes from a specific selection
set indexes [$selection get index]

# Open a file for writing the results
set output [open "$var1.angle.txt" "w"]
set n [molinfo top get numframes]

# Loop over the frames in the trajectory
for {set i 0} {$i < $n} {incr i} {
  # Set the current frame
  molinfo top set frame $i
  
  # calculate the dihedral angle
  set ang [measure angle $indexes]
  
  puts "\t \t progress: $i/$n"

  # Write the angle value to the file
  puts $output "$ang"
}

puts "\t \t progress: $n/$n"
	
# Close the file
close $output
# Print a message
puts "\nAll done. Check $var1.angle.txt for the results.\n"
