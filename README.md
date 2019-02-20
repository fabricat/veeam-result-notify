# Desktop notification about last job run of Veeam Agent for Linux

As of today [Veeam Agent for Linux](https://www.veeam.com/linux-cloud-server-backup-agent.html) is only availbable through CLI interface, and there is no "tray icon" or similar to show the service and jobs status on your desktop environment.

This bash script shows a desktop notification (using "notify-send") about the latest backup job execution results.

It requires:
* Veeam Agent for Linux **version 3** must be installed and configured
* it must be run by a user in the "veeam" group (needed to execute "veeamconfig")
* the "notify-send" command must be available and working

This script can be run also from your personal **"crontab"**.
