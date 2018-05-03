#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=30:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=neural-editor
#SBATCH --mail-type=END
#SBATCH --mail-user=$USER@nyu.edu
#SBATCH --output=slurm_ptb.out
#SBATCH --gres=gpu:1

module purge
module load python/intel/2.7.12

HOME=/home/$USER
DATA_DIR=/scratch/$USER/dl/neural-editor-data
REPO_DIR=$HOME/neural-editor
export TEXTMORPH_DATA=$DATA_DIR

export PYTHONPATH=.:$REPO_DIR:$PYTHONPATH

SINGULARITY_PATH=/share/apps/singularity/2.4.4/bin/singularity
TEXTMORPH_IMG=/beegfs/work/public/singularity/textmorph-1.2.img

$SINGULARITY_PATH exec --nv $TEXTMORPH_IMG python $REPO_DIR/textmorph/edit_model/main.py $REPO_DIR/configs/edit_model/edit_ptb.txt
