#!/bin/bash

#------------------------------------------
# ~/.tmuxifier/layouts/myapp.session.sh
# Run with tmuxifier load-session myapp
#------------------------------------------

PROJECTDIR="/var/www"
PROJECT="MyApp"
SCRIPT=$(echo $PROJECT | sed 's/.*/\L&/')
PORT=3000

#session_root "$PROJECTDIR"
session_root $HOME

if initialize_session "$SCRIPT" ; then

    window_root "$PROJECTDIR"

    new_window "top"
    run_cmd "cd $PROJECTDIR/$PROJECT && git status"

    new_window "lib"
    run_cmd "cd $PROJECTDIR/$PROJECT/lib"

    new_window "moose"
    run_cmd "cd $PROJECTDIR/$PROJECT/lib/$PROJECT"

    new_window "con"
    run_cmd "cd $PROJECTDIR/$PROJECT/lib/$PROJECT/Controller"
    split_h 60
    run_cmd "$PROJECTDIR/$PROJECT/script/$SCRIPT""_server.pl -r -p $PORT"
    select_pane 0

    new_window "views"
    run_cmd "cd $PROJECTDIR/$PROJECT/root/$SCRIPT/src"

    new_window "static"
    run_cmd "cd $PROJECTDIR/$PROJECT/root/$SCRIPT/static"

    #Select the default active window on session creation.
    select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
