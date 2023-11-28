##### COMMANDS #####

clean () {
  rm -rf venv
}

build() {

  # Install Requirements
  pip install --upgrade pip
  pip install -r requirements.txt

  # Clean notebook for VCS
  clean_notebook_for_vcs
}

##### HELPERS #####

clean_notebook_for_vcs() {
  nbstripout --install --attributes .gitattributes
}

# Activate the virtual environment so the remaining code will run within the venv.
python -m venv venv
source venv/bin/activate

# Execute given command with remaining arguments, defaulting the command to release.
COMMAND="build"

if [ $# -gt 0 ]
then
    COMMAND="$1"
    shift

    # Helpful redirect of `test` to `tox_test`.
    if [ "$COMMAND" = "test" ]
    then
        COMMAND="tox_test"
    fi
fi

# Keep the output of "help" clean and easy to read. Otherwise, begin logging all commands.
if [ "$COMMAND" != "help" ]
then
    set -x
fi

$COMMAND "$@"