# Run caption task on MSRVTT
DATATYPE="msrvtt"
VAL_CSV="data/msrvtt/MSRVTT_JSFUSION_test.csv"
DATA_PATH="data/msrvtt/MSRVTT_data.json"
FEATURES_PATH="data/msrvtt/msrvtt_videos_features.pickle"
INIT_MODEL="ckpts/ckpt_msrvtt_caption@server-westlakeT0528/pytorch_model.bin.4"
OUTPUT_ROOT="results"

#? nproc_per_node should set to 1, to avoid NCCL error
eval
CUDA_VISIBLE_DEVICES=0 python -m torch.distributed.launch --nproc_per_node=1 \
main_task_caption.py \
--do_eval --num_thread_reader=4 \
--val_csv ${VAL_CSV} \
--data_path ${DATA_PATH} \
--features_path ${FEATURES_PATH} \
--output_dir ${OUTPUT_ROOT}/ckpt_msrvtt_caption --bert_model bert-base-uncased \
--do_lower_case \
--batch_size_val 32 --visual_num_hidden_layers 6 \
--decoder_num_hidden_layers 3 --datatype ${DATATYPE} --stage_two \
--init_model ${INIT_MODEL}
