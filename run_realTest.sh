# Run caption task on city_traffic with ckpt_msrvtt pretrained model
DATATYPE="msrvtt"
INIT_MODEL="ckpts/ckpt_msrvtt_caption@server-westlakeT0528/pytorch_model.bin.4"

# # city_traffic
# VAL_CSV="data/city_traffic/city_traffic_JSFUSION_test.csv"
# DATA_PATH="data/city_traffic/city_traffic_data.json"
# FEATURES_PATH="data/city_traffic/city_traffic.pickle"
# OUTPUT_ROOT="results/ckpt_msrvtt_caption-city_traffic"

# city_traffic
VAL_CSV="data/sci_city_traffic/pipeline_test.csv"
DATA_PATH="data/sci_city_traffic/pipeline_test.json"
FEATURES_PATH="data/sci_city_traffic/pipeline_test.pickle"
OUTPUT_ROOT="results/ckpt_msrvtt_caption-sci_city_traffic"

# # hcasci_data
# VAL_CSV="data/hcasci_data/hcasci_data_JSFUSION_test.csv"
# DATA_PATH="data/hcasci_data/hcasci_data.json"
# FEATURES_PATH="data/hcasci_data/hcasci_data.pickle"
# OUTPUT_ROOT="results/ckpt_msrvtt_caption-hcasci_data"

#? nproc_per_node should set to 1, to avoid NCCL error
# eval
CUDA_VISIBLE_DEVICES=0 python -m torch.distributed.launch --nproc_per_node=1 \
main_mytask_caption.py \
--do_eval --num_thread_reader=4 \
--val_csv ${VAL_CSV} \
--data_path ${DATA_PATH} \
--features_path ${FEATURES_PATH} \
--output_dir ${OUTPUT_ROOT} --bert_model bert-base-uncased \
--do_lower_case \
--batch_size_val 32 --visual_num_hidden_layers 6 \
--decoder_num_hidden_layers 3 --datatype ${DATATYPE} --stage_two \
--init_model ${INIT_MODEL}