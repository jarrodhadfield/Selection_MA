ref=~/Work/Selection_MA/Data/Raw
out=~/Work/Selection_MA/Data/Intermediate 

oldChr=NC_000913.2
# contig name

CSV=BPS_WT_Foster_et_al_2015.csv
OUT=lifted_coords.bed

minimap2 -x asm5 -c --cs $ref/GCF_000005845.2_ASM584v2_genomic.fna $ref/NC_000913.2.fna  > "$out/913.2_vs_913.3.paf"
# aligns the two genomes

awk -F, 'NR==1{next} {start=$2-1; end=$2; print "'$oldChr'", start, end, $0}' OFS="\t" "$ref/$CSV" > "$out/old_coords.bed"
# takes old coordinates from a csv file (column 2) and converts them to a bed file (counts from zero, tab-delimited)

paftools.js liftover -l 0 "$out/913.2_vs_913.3.paf" "$out/old_coords.bed" > "$out/$OUT"

rm "$out/913.2_vs_913.3.paf"
rm "$out/old_coords.bed"