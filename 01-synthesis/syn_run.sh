rm -rf log/* report/* output/*
dc_shell -f scripts/syn.tcl | tee log/syn.log
rm -rf command.log filenames.log

BASE_DIR="history"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DIR_NAME="synthesis_${TIMESTAMP}"
mkdir -p "./$BASE_DIR/$DIR_NAME"
cp -r ./log "./$BASE_DIR/$DIR_NAME"
cp -r ./cons "./$BASE_DIR/$DIR_NAME"
cp -r ./output "./$BASE_DIR/$DIR_NAME"
cp -r ./report "./$BASE_DIR/$DIR_NAME"
cp -r ./scripts "./$BASE_DIR/$DIR_NAME"

