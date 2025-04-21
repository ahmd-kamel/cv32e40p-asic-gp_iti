rm -rf formality_svf/*
fm_shell -f scripts/syn_fm_script.tcl | tee log/fm.log
rm *.log clog* 

BASE_DIR="history"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DIR_NAME="synthesis_fm_${TIMESTAMP}"
mkdir -p "./$BASE_DIR/$DIR_NAME"
cp -r ./log "./$BASE_DIR/$DIR_NAME"
cp -r ./cons "./$BASE_DIR/$DIR_NAME"
cp -r ./output "./$BASE_DIR/$DIR_NAME"
cp -r ./report "./$BASE_DIR/$DIR_NAME"
cp -r ./scripts "./$BASE_DIR/$DIR_NAME"

