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
    echo -e "\e[33;1mStarting Adminhtml Script\e[0m"
    echo -e "\e[33;1mClearing Static Files\e[0m"
    rm -rf var/view_preprocessed pub/static/backend/*
    echo -e "\e[33;1mDeploying Static Content\e[0m"
    bin/magento setup:static-content:deploy --area backend -f
    echo -e "\e[33;1mCleaning and Flushing Cache\e[0m"
    bin/magento cache:clean
    bin/magento cache:flush
    echo -e "\e[33;1mAdminhtml Script COMPLETE\e[0m"
fi
