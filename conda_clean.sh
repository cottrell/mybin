#!/bin/bash
# for use in crontab for example
source ~/anaconda3/etc/profile.d/conda.sh
# FLAG="--dry-run"
FLAG=
# conda clean $FLAG --index-cache
# conda clean $FLAG --packages
# conda clean $FLAG --tarballs
conda clean $FLAG --all
conda clean $FLAG --tempfiles
conda clean $FLAG --logfiles
