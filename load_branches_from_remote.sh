#!/usr/bin/env bash

# Delete all local branches and create all non-remote-tracking branches of a specified remote
#
# Usage: load_branches_from_remote.sh <remote-name>
#
# Example: load_branches_from_remote.sh origin

REMOTE=$1
echo "Loading all branches from the remote '$REMOTE' (all local branches are deleted)"
# Checking out orphan commit so it 's possible to delete current branch
git checkout --orphan void
# Delete all local branches
for BRANCH in `git branch`; do
    git branch -D $BRANCH
done
# Create non-remote-tracking branches from selected remote
for REMOTE_BRANCH in $(git branch -r|grep $REMOTE/); do
    BRANCH=${REMOTE_BRANCH/$REMOTE\//}
    git branch -q $BRANCH $REMOTE_BRANCH
    git branch --unset-upstream $BRANCH
done
git checkout -f main

