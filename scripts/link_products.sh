BSZ=512
GPU=$1
total_steps=$2
seed=$3
MULTI_TASK_STR=$4
name=$5
pareto_option=$6
DATASET=products
LR=1e-4
DIM1=256
DIM2=256
ROOT_CHECKPOINT="SSL_training_${seed}_link"


CUDA_VISIBLE_DEVICES=${GPU} python ../pretrain_model.py \
--world_size 1 \
--worker 1 \
--name ${name} \
--checkpoint_dir "${ROOT_CHECKPOINT}/${DATASET}" \
--dataset ${DATASET} \
--split random \
--pretrain_label_dir ../pretrain_labels \
--total_steps ${total_steps} \
--warmup_step 100 \
--per_gpu_batch_size ${BSZ} \
--use_saint \
--batch_size_multiplier_minsg 40 \
--batch_size_multiplier_ming 40 \
--khop_ming 3 \
--khop_minsg 1 \
--lr ${LR} \
--optim adamw \
--scheduler fixed \
--weight_decay 1e-5 \
--temperature_gm 0.2 \
--temperature_minsg 0.1 \
--sub_size 256 \
--decor_size 100000 \
--decor_lamb 1e-3 \
--hid_dim ${DIM1} ${DIM1} ${DIM1} \
--predictor_dim 1024 \
--inter_dim 0 \
--norm layer \
--dropout 0. \
--seed ${seed} \
--hetero_graph_path ../hetero_graphs \
--tasks ${MULTI_TASK_STR} \
${pareto_option} \
--use_prelu \
--mask_edge \
--tvt_addr ../links/${DATASET}_tvtEdges.pkl 