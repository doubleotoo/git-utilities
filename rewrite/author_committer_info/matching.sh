#!/bin/sh
#
# Rewrite __matching__ commits:
#
#   * Change committer name + email
#   * Change author name + email
source "$(dirname "$0")"/../utilities.sh

export TARGET_NAME='Joe Smith'
export TARGET_EMAIL='jsmith@gmail.com'
export NEW_NAME='Justin Too'
export NEW_EMAIL='doubleotoo@gmail.com'

# example rewrite-staging-20120317-151959
DEFAULT_REWRITE_STAGING_BRANCH=rewrite-staging-$(date +%Y%m%d-%H%M%S)
REWRITE_STAGING_BRANCH=$DEFAULT_REWRITE_STAGING_BRANCH

##------------------------------------------------------------------------------
##  Confirmation
##------------------------------------------------------------------------------
cat <<-EOF
ALL matching Git commits will be rewritten, as follows:

  $TARGET_NAME ~> $NEW_NAME
  $TARGET_EMAIL ~> $NEW_EMAIL

EOF

confirm_rewrite
checkout_staging_branch

##------------------------------------------------------------------------------
##  Rewrite!
##------------------------------------------------------------------------------
# enable shell command tracing
: set -x

git filter-branch --force --env-filter '

name="$GIT_AUTHOR_NAME"
email="$GIT_AUTHOR_EMAIL"

case "$name" in
    "$TARGET_NAME") name="$NEW_NAME" ; email="$NEW_EMAIL" ;;
esac

case "$email" in
    "$TARGET_EMAIL") name="$NEW_NAME" ; email="$NEW_EMAIL" ;;
esac

export GIT_AUTHOR_NAME="$name"
export GIT_AUTHOR_EMAIL="$email"
export GIT_COMMITTER_NAME="$name"
export GIT_COMMITTER_EMAIL="$email"
'

