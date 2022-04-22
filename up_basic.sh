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
    echo -e "\e[33;1mStarting Basic Script\e[0m"
    # Runs setup:upgrade
    echo -e "\e[33;1mRunning Setup Upgrade\e[0m"
    bin/magento setup:upgrade
    # Runs setup:di:compile
    echo -e "\e[33;1mRunning Compiler\e[0m"
    bin/magento setup:di:compile
    echo -e "\e[33;1mBasic Script COMPLETE\e[0m"
fi
