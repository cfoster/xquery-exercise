HOST=
USER=admin
PASS=admin
XDBC_PORT=9596

mlcp.sh import -host $HOST -port $XDBC_PORT -username $USER -password $PASS \
        -input_file_path ../test-data \
        -output_collections "data,data-clip,data-audio_video"