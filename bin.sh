#!/bin/bash
#SBATCH --job-name=metabat_2017_bins
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=48:00:00
#SBATCH --mem=100gb
#SBATCH --partition=batch,guest
#SBATCH --output=/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs/metabat_2017_%j.out
#SBATCH --error=/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs/metabat_2017_%j.err

set -euo pipefail

module load metabat2

# -----------------------------
# INPUT CONTIGS
# -----------------------------
CONTIGS="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/2017_Steers_MD01_Assembly.fa"

# -----------------------------
# OUTPUT FOLDER (NEW FOLDER)
# -----------------------------
OUTDIR="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/metabat_bins_2017"
LOGDIR="/work/samodha/sachin/MWAS/Predicted_ORF/CoASSMBLYS/logs"

mkdir -p "$OUTDIR" "$LOGDIR"

echo "============================================"
echo "MetaBAT2 (contigs-only) binning"
echo "Input contigs: $CONTIGS"
echo "Output folder: $OUTDIR"
echo "Threads: 16"
echo "Min contig length: 1500"
echo "============================================"

# Quick sanity check
if [[ ! -s "$CONTIGS" ]]; then
  echo "ERROR: Contigs file not found or empty: $CONTIGS" >&2
  exit 1
fi

# -----------------------------
# RUN METABAT2 (CONTIGS ONLY)
# -----------------------------
metabat2 \
  -i "$CONTIGS" \
  -o "$OUTDIR/bin" \
  -m 1500 \
  -t 16 \
  -v

echo "✅ Done. Bins are here: $OUTDIR"
echo "Example outputs: $OUTDIR/bin.1.fa, $OUTDIR/bin.2.fa ..."
