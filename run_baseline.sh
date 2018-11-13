#!/usr/bin/env bash

python nmt.py \
    --train_src data/iwslt14/train.de \
    --train_tgt data/iwslt14/train.en \
    --dev_src data/iwslt14/valid.de \
    --dev_tgt data/iwslt14/valid.en \
    --test_src data/iwslt14/test.de \
    --test_tgt data/iwslt14/test.en \
    --vocab vocab.bin \
    --decode_max_time_step 50 \
    --batch_size 80 \
    --model_type ml \
    --beam_size 1 \
    --log_every 1000 \
    --save_to mle_model \
    --save_to_file test_result.txt \
    --mode train \
    --valid_niter 4788 \
    --cuda

#load_model_name=mle_update
#python nmt.py \
#    --train_src data/iwslt14/train.de \
#    --train_tgt data/iwslt14/train.en \
#    --dev_src data/iwslt14/valid.de \
#    --dev_tgt data/iwslt14/valid.en \
#    --test_src data/iwslt14/test.de \
#    --test_tgt data/iwslt14/test.en \
#    --vocab ./vocab.bin \
#    --decode_max_time_step 200\
#    --batch_size 32\
#    --model_type ml \
#    --log_every 50\
#    --load_model $load_model_name.bin \
#    --mode test\
#    --valid_niter 1000 \
#    --cuda
