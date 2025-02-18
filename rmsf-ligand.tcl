#First align trajectory, using RMSD trajectory tool.
#Specify ligand name in line 22 and last frame number in line 28

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

set outfile [open RMSF-LIG.txt w]

# Create a selection for the ligand atoms
set ligand_selection "resname DRV"

# Get the ligand atom selection
set ligand_sel [atomselect top $ligand_selection]

# Specify the last frame index
set last_frame_index 999

# Calculate the RMSF for all ligand atoms
set rmsf [measure rmsf $ligand_sel first 0 last $last_frame_index step 1]

# Get the atom indices and names
set atom_names [$ligand_sel get name]

# Print the RMSF values with atom indices and names
for {set i 0} {$i < [$ligand_sel num]} {incr i} {
    puts $outfile "[lindex $atom_names $i] [lindex $rmsf $i]"
}

close $outfile

