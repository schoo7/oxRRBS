# trim
ls *_1.fq.gz | xargs -P6 -I@ bash -c 'trim_galore -a AGATCGGAAGAGC -a2 AAATCAAAAAAAC --paired -o trimmed "$1" ${1%_1.*.*}_2.fq.gz' _ @
# diversity adaptor trim
ls *_1_trimmed.fq.gz | xargs -P6 -I@ bash -c 'python trimRRBSdiversityAdaptCustomers.py -1 "@" -2 "${@%_1_trimmed.fq.gz}_2_trimmed.fq.gz"' @

