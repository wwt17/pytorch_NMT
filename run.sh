#!/usr/bin/env bash

python nmt.py \
    --train_src data/iwslt14/train.de \
    --train_tgt data/iwslt14/train.en \
    --dev_src data/iwslt14/valid.de \
    --dev_tgt data/iwslt14/valid.en \
    --test_src data/iwslt14/test.de \
    --test_tgt data/iwslt14/test.en \
    --vocab vocab.bin \
    --decode_max_time_step 60 \
    --batch_size 64 \
    --model_type ml \
    --dropout 0.2 \
    --beam_size 5 \
    --log_every 1000 \
    --save_to mle_model_for_mixer \
    --save_to_file test_result.txt \
    --mode train \
    --valid_niter 2394 \
    --cuda


python nmt.py \
    --train_src data/iwslt14/train.de \
    --train_tgt data/iwslt14/train.en \
    --dev_src data/iwslt14/valid.de \
    --dev_tgt data/iwslt14/valid.en \
    --test_src data/iwslt14/test.de \
    --test_tgt data/iwslt14/test.en \
    --vocab ./vocab.bin \
    --batch_size 64 \
    --beam_size 5 \
    --dropout 0.2 \
    --decode_max_time_step 60 \
    --model_type mixer \
    --valid_niter 2394 \
    --valid_metric 'bleu' \
    --log_every 1000 \
    --save_to mixer_model \
    --reward_type "bleu" \
    --load_model mle_model_for_mixer.bin \
    --cuda

