#!/usr/bin/env bash

python vocab.py \
    --src_vocab_size 32007 \
    --tgt_vocab_size 22820 \
    --include_singleton \
    --train_src data/iwslt14/train.de \
    --train_tgt data/iwslt14/train.en \
    --output vocab.bin