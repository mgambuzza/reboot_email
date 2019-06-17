#convert your plain text password to secure credentials
#when run, will pop up asking for your password, and will then create output file in specified folder, eg
#read-host -assecurestring | convertfrom-securestring | out-file C:\scripts\email@account.onmicrosoft.com.txt
#will create a txt file in c:\scripts with password as an encrypted string
#replace foldername and office365emailaccount with your required parameters.
read-host -assecurestring | convertfrom-securestring | out-file C:\foldername\office365emailaccount.txt