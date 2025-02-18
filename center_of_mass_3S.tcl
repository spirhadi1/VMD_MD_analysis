
###############################################################
# center_of_mass_3S.tcl                                       #
#                                                             #
# DESCRIPTION:                                                #
# This script calcultes the center of mass distance           #
# between three groups and allows users to choose three       #
# regions of macromolecule.                                   # 
#                                                             #   
# EXAMPLE USAGE:                                              #
#         source center_of_mass_3S.tcl                        #
#         Selection 1: chain A and resid 10                   #
#         Selection 2: Cahin B and resid 10                   #
#         Selection 3: Cahin B and resid 11                   #
#                                                             #
# Jan 12, 2023, Schiffer Lab                                  #
###############################################################

puts -nonewline "\n \t \t Selection 1: "
gets stdin var1

puts -nonewline "\n \t \t Selection 2: "

gets stdin var2

puts -nonewline "\n \t \t Selection 3: "

gets stdin var3
# selection
set sel1 [atomselect top "$var1"]
set sel2 [atomselect top "$var2"]
set sel3 [atomselect top "$var3"]

set n [molinfo top get numframes]
set output [open "center_mass_$var1.$var2.$var3.txt" w]

# calculation loop
for {set i 0} {$i < $n} {incr i} {
	molinfo top set frame $i
	    set com1 [measure center $sel1]
	    set com2 [measure center $sel2]
	    set com3 [measure center $sel3]
	    set dist12 [veclength [vecsub $com1 $com2]]
            set dist23 [veclength [vecsub $com2 $com3]]
            set dist13 [veclength [vecsub $com1 $com3]]
            puts "Distance at frame $i is $dist12, $dist23, $dist13 angstroms"
	    #set d [veclength [vecsub $com1 $com2 $com3]]
        puts "\t \t progress: $i/$n"
        puts $output "$i $dist12 $dist23 $dist13"

}
puts "\t \t progress: $n/$n"

close $output
puts "\nAll done.\n"
puts "\nCheck center_mass_$var1.$var2.$var3.txt for the results.\n"

