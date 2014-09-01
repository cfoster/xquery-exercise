HOST=
USER=admin
PASS=admin
XDBC_PORT=9596

mlcp.sh import -host $HOST -port $XDBC_PORT -username $USER -password $PASS \
        -input_file_path ../xquery \
        -output_uri_replace "/Users/cfoster/Documents/crf/projects/bbc/xquery-exercise/xquery,''"