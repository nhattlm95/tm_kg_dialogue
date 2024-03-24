echo "Inference with both dialogue history and response"

python train_ctm.py \
--do_eval_dial \
--dataset wow \
--vocab_path save/models/topic_models/ctm_new_vocab_20k.pkl \
--data_preparation_file save/models/topic_models/data_cache.pkl \
--model_path_prefix save/models/topic_models/ctm_20k_topics_ \
--output_path save/models/topic_models/ctm_20k_new_hisres_NCLUSTER/wow_20k_new_hisres_ \
--sbert_name sentence-transformers/stsb-roberta-base-v2 \



