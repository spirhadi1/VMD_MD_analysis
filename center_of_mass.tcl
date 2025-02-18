
###############################################################
# center_of_mass.tcl                                          #
#                                                             #
# DESCRIPTION:                                                #
# This script calcultes the center of mass distance           #
# between two groups and allows users to choose two           #
# regions of macromolecule.                                   # 
#                                                             #   
# EXAMPLE USAGE:                                              #
#         source center_of_mass.tcl                           #
#         Selection: chain A and resid 10                     #
#         Selection: Cahin B and resid 10                     #
#                                                             #
# Jan 12, 2023, Schiffer Lab                                  #
###############################################################

puts -nonewline "\n \t \t Selection 1: "
gets stdin var1

puts -nonewline "\n \t \t Selection 2: "
gets stdin var2

# selection
set sel1 [atomselect top "$var1"]
set sel2 [atomselect top "$var2"]


set n [molinfo top get numframes]
set output [open "center_mass_$var1.$var2.txt" w]

# calculation loop
for {set i 0} {$i < $n} {incr i} {
	molinfo top set frame $i
	    set com1 [measure center $sel1]
	    set com2 [measure center $sel2]
	    set d [veclength [vecsub $com1 $com2]]
        puts "\t \t progress: $i/$n"
        puts $output "$i $d"

}
puts "\t \t progress: $n/$n"

close $output
puts "\nAll done.\n"
puts "\nCheck center_mass_$var1.$var2.txt for the results.\n"

