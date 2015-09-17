#!/bin/sh

# generate the continous common points
# --------------------------
GLOBAL=$BASE_DIR/$GLOBAL_STOCK_DIR_NAME
ORIGINAL_STOCK_FILE=$GLOBAL/$STOCK_FILE_NAME
GLOBAL_VECS=$BASE_DIR/$GLOBAL_VEC_DIR_NAME
GLOBAL_POINTS=$BASE_DIR/$GLOBAL_POINTS_DIR_NAME
CONT_VECS=$BASE_DIR/$VECS_DIR_NAME
CONT_POINTS=$BASE_DIR/$POINTS_DIR_NAME
CONT_COMMON_POINTS=$BASE_DIR/$CONT_COMMON_POINTS_DIR_NAME
CONT_COMMON_WEIGHTS=$BASE_DIR/$COMMON_WEIGHTS_DIR_NAME
GLOBAL_CONT_COMMON_POINTS=$BASE_DIR/$GLOBAL_COMMON_POINTS_DIR_NAME
GLOBAL_CONT_COMMON_WEIGHTS=$BASE_DIR/$GLOBAL_COMMON_WEIGHTS_DIR_NAME

mkdir -p $CONT_COMMON_POINTS
mkdir -p $GLOBAL_CONT_COMMON_POINTS
mkdir -p $CONT_COMMON_WEIGHTS
mkdir -p $GLOBAL_CONT_COMMON_WEIGHTS

# copy the global points
mkdir -p $BASE_DIR/$GLOBAL_FINAL_POINTS_DIR
cp -r $GLOBAL_POINTS/* $BASE_DIR/$GLOBAL_FINAL_POINTS_DIR

java -cp ../mpi/target/stocks-1.0-ompi1.8.1-jar-with-dependencies.jar ContinuousCommonGenerator -v $CONT_VECS -p $CONT_POINTS -d $CONT_COMMON_POINTS -sf $ORIGINAL_STOCK_FILE -s "UNH,GS,CVX,MCD,BA,GE,WMT,INTC,MSFT,IBM" | tee $BASE_DIR/$POSTPROC_INTERMEDIATE_DIR_NAME/common.points.out.txt

