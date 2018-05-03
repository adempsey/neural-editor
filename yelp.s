#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=30:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=neural-editor
#SBATCH --mail-type=END
#SBATCH --mail-user=netid@nyu.edu
#SBATCH --output=slurm_yelp.out
#SBATCH --gres=gpu:1

HOME=/home/netid
DATA_DIR=$HOME/neural-editor-data
REPO_DIR=$HOME/neural-editor
export TEXTMORPH_DATA=$DATA_DIR

export PYTHONPATH=.:$REPO_DIR:$PYTHONPATH

/share/apps/singularity/2.4.4/bin/singularity exec --nv /beegfs/work/public/singularity/textmorph-1.2.img python $REPO_DIR/textmorph/edit_model/main.py $REPO_DIR/configs/edit_model/edit_logp.txt

touch yelp.txt

cat slurm_yelp.out | grep bleu > yelp.txt
