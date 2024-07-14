# trim
ls *_1.fq.gz | xargs -P12 -I@ bash -c 'trim_galore -a AGATCGGAAGAGC -a2 AAATCAAAAAAAC --paired -o trimmed "$1" ${1%_1.*.*}_2.fq.gz' _ @
# diversity adaptor trim

#!/bin/bash

# Define the maximum number of concurrent tasks
conda activate py2env
max_tasks=16

# Function to process each pair of files
process_files() {
  local r1_file=$1
  local r2_file=$2
  python trimRRBSdiversityAdaptCustomers.py -1 $r1_file -2 $r2_file
}

# Iterate over the sequence
for i in $(seq 1 32); do
  # Generate file names
  r1_file="L${i}_R1.fq.gz"
  r2_file="L${i}_R2.fq.gz"
  
  # Call the function in background
  process_files "$r1_file" "$r2_file" &
  
  # Control the number of concurrent processes
  if (( $(jobs -r -p | wc -l) >= max_tasks )); then
    wait -n
  fi
done

# Wait for all remaining background jobs to finish
wait
