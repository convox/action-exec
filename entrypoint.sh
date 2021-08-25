export CONVOX_RACK=$INPUT_RACK

echo "Running command on the application."
convox exec $INPUT_SERVICE "$INPUT_COMMAND" --app $INPUT_APP --rack $INPUT_RACK