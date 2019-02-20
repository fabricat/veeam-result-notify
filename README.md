# Desktop notification about last job run of Veeam Agent for Linux

[Veeam Agent for Linux](https://www.veeam.com/linux-cloud-server-backup-agent.html) is only availbable through CLI interface, and there is no "tray icon" or similar to show the service and jobs status on your desktop environment.

This bash script shows a desktop notification (using "notify-send") about the latest backup job execution results.

## Requirements
* Veeam Agent for Linux **version 3** must be installed and configured
* the script must be run by a user in the "veeam" group (needed by "veeamconfig")
* the "[notify-send](https://ss64.com/bash/notify-send.html)" command must be installed (see "[libnotify-bin](https://packages.debian.org/it/sid/libnotify-bin)" for Debian)

:thumbsup: If you have all these requisites, this script can be also run by "**crontab**".

### Tested on:
* Linux Mint 19 Tara + Cinnamon
* Linux Mint 18.3 Sylvia + Cinnamon
