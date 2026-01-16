#!/bin/bash
#SBATCH --job-name=metabat_2019_ME01_Nov
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=48:00:00
#SBATCH --mem=100gb
#SBATCH --partition=batch,guest
#SBATCH --output=/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs/metabat_2019_ME01_Nov_%j.out
#SBATCH --error=/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs/metabat_2019_ME01_Nov_%j.err

set -euo pipefail

module load metabat2

# -----------------------------
# INPUT CONTIGS
# -----------------------------
CONTIGS="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/Nov_2019_Steers_ME01.fa"

# -----------------------------
# OUTPUT DIRECTORIES
# -----------------------------
OUTDIR="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/metabat_bins_Nov_2019_ME01"
LOGDIR="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs"

# Create folders if they do not exist
mkdir -p "$OUTDIR" "$LOGDIR"

echo "============================================"
echo "MetaBAT2 contigs-only binning"
echo "Input contigs : $CONTIGS"
echo "Output folder : $OUTDIR"
echo "Threads       : 16"
echo "Min contig bp : 1500"
echo "============================================"

# Sanity check
if [[ ! -s "$CONTIGS" ]]; then
  echo "ERROR: Contigs file not found or empty: $CONTIGS" >&2
  exit 1
fi

# -----------------------------
# RUN METABAT2
# -----------------------------
metabat2 \
  -i "$CONTIGS" \
  -o "$OUTDIR/bin" \
  -m 1500 \
  -t 16 \
  -v

echo "✅ MetaBAT2 finished successfully"
echo "Bins saved in: $OUTDIR"
