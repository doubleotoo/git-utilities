#!/bin/bash
#
# Git rewrite utility functions.

# confirm(void)
#
#  Prompt user for confirmation to proceed with rewrite.
#
#  Returns::
#
#     0   if confirmation succeeded
#     1   if confirmation failed
#
function confirm_rewrite() {
    read -p "Should I rewrite? y[es] n[o]> " -n 1
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo
        echo "[confirm]::Exiting: no action to perform (phew)..."
        return 1
    else
        echo
        return 0
    fi
}

# checkout_staging_branch(void)
#
#  Creates a staging branch and then checks it out.
#
#  This is useful for performing Git operations with possibly
#  severe or dangerous side-effects.
#
# 
#  Default::
#
#     rewrite-staging-<datetime>
#
#  Example::
#
#     rewrite-staging-20120317-151959
#
#
function checkout_staging_branch() {
    local DEFAULT_REWRITE_STAGING_BRANCH=rewrite-staging-$(date +%Y%m%d-%H%M%S)
    local REWRITE_STAGING_BRANCH=$DEFAULT_REWRITE_STAGING_BRANCH

    # staging branch
    read -p "[create_staging_branch]::branch to perform rewrite on [default: '$DEFAULT_REWRITE_STAGING_BRANCH']> "
    if [ -z "$REPLY" ]; then
        REWRITE_STAGING_BRANCH=$DEFAULT_REWRITE_STAGING_BRANCH   
    else
        # TODO: normalize
        REWRITE_STAGING_BRANCH=$REPLY
    fi

    echo 
    git branch $REWRITE_STAGING_BRANCH || return 1
    git checkout $REWRITE_STAGING_BRANCH || return 1
}

