#First align trajectory using "RMSD trajectory tool". Specify the last frame number in line 22. Use it as "source rmsf.tcl" in VMD tcl

set reference [atomselect top "protein" frame 1]
# the frame being compared
set compare [atomselect top "protein"]
set num_steps [molinfo top get numframes]

for {set frame 0} {$frame < $num_steps} {incr frame} {
  # get the correct frame
  $compare frame $frame

  # compute the transformation
  set trans_mat [measure fit $compare $reference]
  # do the alignment
  $compare move $trans_mat
}


set outfile [open RMSF.txt w]
set sel [atomselect top "name CA"]
#puts $outfile "[measure rmsf $sel first 1 last 2000 step 1]"
set rmsf [measure rmsf $sel first 0 last 2500 step 1]
for {set i 0} {$i < [$sel num]} {incr i} {
  puts $outfile "[expr {$i+1}] [lindex $rmsf $i]"
} 
close $outfile
