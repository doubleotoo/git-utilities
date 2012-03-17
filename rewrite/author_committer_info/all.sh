#!/bin/bash -e
#
# Rewrite ALL commits:
#
#   * Change committer name + email
#   * Change author name + email
source "$(dirname "$0")"/../utilities.sh

export AUTHOR_NAME='Joe Smith'
export AUTHOR_EMAIL='jsmith@gmail.com'
export COMMITTER_NAME="$AUTHOR_NAME"
export COMMITTER_EMAIL="$AUTHOR_EMAIL"

##------------------------------------------------------------------------------
##  Confirmation
##------------------------------------------------------------------------------
cat <<-EOF
ALL Git commits will be rewritten, as follows:

  GIT_AUTHOR_NAME ~> $AUTHOR_NAME
  GIT_AUTHOR_EMAIL ~> $AUTHOR_EMAIL

  GIT_COMMITTER_NAME ~> $COMMITTER_NAME
  GIT_COMMITTER_EMAIL ~> $COMMITTER_EMAIL


!! Warning: this is risky !!

EOF

confirm_rewrite
checkout_staging_branch

##------------------------------------------------------------------------------
##  Rewrite!
##------------------------------------------------------------------------------
# enable shell command tracing
: set -x

git filter-branch --force --env-filter '

export GIT_AUTHOR_NAME="$AUTHOR_NAME"
export GIT_AUTHOR_EMAIL="$AUTHOR_EMAIL"
export GIT_COMMITTER_NAME="$COMMITTER_NAME"
export GIT_COMMITTER_EMAIL="$COMMITTER_EMAIL"
'

