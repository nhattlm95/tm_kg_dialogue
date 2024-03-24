
# About


The implementation of the paper 

**Enhancing Knowledge Retrieval with Topic Modeling for  
Knowledge-Grounded Dialogue**. Nhat Tran and [**Diane Litman**](https://people.cs.pitt.edu/~litman/), **LREC-Coling 2024**.
## Install environment
```console
pip install -r requirements.txt
pip install -U contextualized_topic_models==2.0.1
```

## Prepare data

In this paper, we conduct experiments on MultiDoc2Dial and KILT-dialogue dataset.

For MultiDoc2Dial, download and extract the data from [link](https://doc2dial.github.io/multidoc2dial/file/multidoc2dial.zip).

For KILT-dialogue, download the following 3 files: [train](https://dl.fbaipublicfiles.com/KILT/wow-train-kilt.jsonl), [dev](http://dl.fbaipublicfiles.com/KILT/wow-dev-kilt.jsonl)  and [knowledge source](http://dl.fbaipublicfiles.com/KILT/kilt_knowledgesource.json)

The data (.json and .jsonl files) should be put under `data` folder.

## Parameters
Modify the parameters in `params.txt`

* top_K: the number of retrieved passages (default is 5).
* T_multidoc2dial: the number of topics T for MultiDoc2Dial dataset.
* T_kilt_dialogue: the number of topics T for KILT-dialogue dataset.

## Topic Modeling Training

### Train and inference on knowledge corpus

Train a CTM on the knowledge corpus and classify all the articles into a specific number of clusters:

```console
python train_ctm.py \
--do_train \
--do_eval_doc \
--dataset data/multidoc2dial_doc.json \ # Change this to 'data/kilt_knowledgesource.json' for KILT-dialogue
--vocab_path save/models/topic_models/ctm_new_vocab_20k.pkl \
--data_preparation_file save/models/topic_models/data_cache.pkl \
--model_path_prefix save/models/topic_models/ctm_20k_topics_ \
--output_path save/models/topic_models/ctm_20k_topics_NCLUSTER/DATASET_ctm_20k_topics_ \
--sbe
```
### Inference

Next, we classify all the dialogue samples into different clusters:

```console
python train_ctm.py \
--do_eval_dial \
--dataset data/multidoc2dial_doc.json \ # Change this to 'data/kilt_knowledgesource.json' for KILT-dialogue
--vocab_path save/models/topic_models/ctm_new_vocab_20k.pkl \
--data_preparation_file save/models/topic_models/data_cache.pkl \
--model_path_prefix save/models/topic_models/ctm_20k_topics_ \
--output_path save/models/topic_models/ctm_20k_new_SB_NCLUSTER/wow_20k_new_SB_ \
--sbert_name save/models/topic_models/his_only_sentenceBert
```


## Experiments

Run `rag_topic.py` for RAG_topic or `rag_context_topic` for RAG_context_topic model (only for Multidoc2Dial).

```console
python rag_topic.py \
--dataset multidoc2dial \ # Change this to kilt_dialogue for KILT-dialogue
--output_dir $OUTPUT_DIR \
--model_type rag_token \
--fp16 \\
```

```console
python rag_context_topic.py \
--output_dir $OUTPUT_DIR \
--model_type rag_token \
--fp16 \\
```