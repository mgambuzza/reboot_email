# reboot_email
Send email on machine reboot
I use this script to send an email when a server has been rebooted, mainly to make sure people aren't doing things they shouldn't.

Shout out to @girlgerms for her initial script (https://girl-germs.com/?p=1079).

It gets the last EventiD 1074 entry in the System event log, parses that and turns it into individual variables.

Script has been updated to work with office365 smtp server, and use encrypted credentials. You will need to run the create_secure_password.ps1 script first to create your encrypted password file.
