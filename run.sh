#!/usr/bin/env bash
#SBATCH --job-name=MIXER_run
#SBATCH --gres=gpu:1
#SBATCH --mem=30g
#SBATCH -c 8
#SBATCH --time 0
#SBATCH -o .log.MIXER_run

#set -x  # echo commands to stdout
#set -e  # exit on error

if [[ $(hostname -s) = compute-* ]]; then
	module load cuda-91
	module load cudnn-9.1-7.1
	source ${HOME}/.bashrc
fi

model_name=mle_rl_bleu
load_model_name=mle_update

data_config="
    --train_src data/iwslt14/train.de
    --train_tgt data/iwslt14/train.en
    --dev_src data/iwslt14/valid.de
    --dev_tgt data/iwslt14/valid.en
    --test_src data/iwslt14/test.de
    --test_tgt data/iwslt14/test.en
    --vocab vocab.bin"
batch_size=80
decode_max_time_step=50
log_every=1000
valid_niter=1916

python nmt.py \
	${data_config} \
    --model_type ml \
    --batch_size ${batch_size} \
    --dropout 0.2 \
    --beam_size 1 \
    --decode_max_time_step ${decode_max_time_step} \
    --log_every ${log_every} \
    --valid_niter ${valid_niter} \
    --save_to mle_model \
    --save_to_file mle_test_result.txt \
    --load_model mle_model.bin \
    --max_nepoch 20 \
	--cuda

python nmt.py \
	${data_config} \
    --model_type mixer \
    --reward_type "bleu" \
    --batch_size ${batch_size} \
    --dropout 0.2 \
    --beam_size 1 \
    --decode_max_time_step ${decode_max_time_step} \
    --log_every ${log_every} \
    --valid_niter ${valid_niter} \
    --save_to mixer_model \
    --save_to_file mixer_test_result.txt \
    --load_model mle_model.bin \
    --cuda
