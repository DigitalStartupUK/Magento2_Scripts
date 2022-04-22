# Magento2_Scripts

This Repo contains scripts that can be downloaded and customised for your own use. I'm to take Pull Requests if you see room for improvement. Bare in mind, I've kept this quite generic so that it's more applicable to a wider group of people.

## The problem
Entering a bunch of commands after you make a change is a boring task. It's the same old thing after makind a Code/Styling change to Magento 2. In the past, I've circumvented this by stringing commands together onto a single line (e.g. `bin/magento setup:upgrade && bin/magento:di:compile`). This is much more convenient than executing one line at a time. However, I still need to dig out my notes so I can copy and paste these commands whenever I need them.

## The Solution
So, to optimise my workflow, I've created some scripts. That way, I only need to know the name of the script I wish to execute rather than dig out the whole string.

## The Scripts
1. `up_basic.sh` : Very Basic. Typically ran after installing a light module or patch.

```
bin/magento setup:upgrade
bin/magento setup:di:compile
```

2. `up_advanced.sh` : Same as above, but includes clearing a bunch of caching. I'd run this after bigger code changes or upgrades.

```
rm -rf var/cache/* var/page_cache/* generated/code/* var/view_preprocessed pub/static/frontend/*
redis-cli flushall
bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento setup:static-content:deploy -f
bin/magento indexer:reindex
bin/magento cache:clean
bin/magento cache:flush
redis-cli flushall
```

3. `up_frontend.sh` : This one clears a bunch of caches if you're only making frontend changes.

```
rm -rf var/view_preprocessed pub/static/frontend/*
bin/magento setup:static-content:deploy --area frontend -f
bin/magento cache:clean
bin/magento cache:flush
```

The scripts are designed to stop instantly as a query exits while having a non-zero status (hence the `set -e`). I've also added some Verbose feedback for the user (`echo`).

## Installation
1. Upload to `<magento root>/bin/` (e.g. `<magento root>/bin/up_basic.sh`)
2. Ensure that the scripts are owner by the magento user (e.g. `magento www-data') [important because of next step]
3. Set the appropriate permissions so only magento user can run the scripts (e.g. `chmod 744 bin/up_basic.sh`)
4. Run the script at any time from the Magento Root Directory (e.g. bin/up_basic.sh)

## Disclaimer
It's my belief that these scripts are secure with the appropriate ownership and permissions. And I'm pretty sure it's ok to store them in the `bin/` folder. However, do so at your own risk as there's every chance I might be wrong.

## Useful Resources

* [Digital Startup Forum](https://digitalstartup.co.uk/)
* [Digital Startup YouTube Channel](https://www.youtube.com/channel/UCacwUJ5gxGgBXkqea0j122A)
