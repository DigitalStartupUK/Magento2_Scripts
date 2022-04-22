#!/bin/bash

############################
#  Magento Script
#  by DigitalStartup.co.uk
#
#  version 1.0.1
############################

set -e

read -p "Are you sure? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\e[33;1mStarting Advanced Script\e[0m"
    echo -e "\e[33;1mClearing Static Files\e[0m"
    rm -rf var/cache/* var/page_cache/* generated/code/* var/view_preprocessed pub/static/frontend/*
    echo -e "\e[33;1mFlushing Redis\e[0m"
    redis-cli flushall
    echo -e "\e[33;1mRunning Setup Upgrade\e[0m"
    bin/magento setup:upgrade
    echo -e "\e[33;1mRunning Compiler\e[0m"
    bin/magento setup:di:compile
    echo -e "\e[33;1mDeploying Static Content\e[0m"
    bin/magento setup:static-content:deploy -f
    echo -e "\e[33;1mRunning Reindexer\e[0m"
    bin/magento indexer:reindex
    echo -e "\e[33;1mCleaning and Flushing Cache\e[0m"
    bin/magento cache:clean
    bin/magento cache:flush
    echo -e "\e[33;1mFlushing Redis\e[0m"
    redis-cli flushall
    echo -e "\e[33;1mAdvanced Script COMPLETE\e[0m"
fi
