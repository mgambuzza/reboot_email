# ------------------------------------------------------ 
# SMTP configuration: username, password, SSL and so on
# ------------------------------------------------------ 
$email_username = "your office 365 account";
$email_password = cat C:\foldername\office365account@server.onmicrosoft.com.txt | convertto-securestring;
$email_smtp_host = "smtp.office365.com";
$email_smtp_port = 587;
$email_smtp_SSL = 1;
$email_from_address = "your office 365 account";
$email_to_addressArray = @("recipient@server.com");
 
# Look for the last event with EventID 1074 in the System log.
$EventInfo = Get-WinEvent -FilterHashtable @{logname='System'; id=1074} -MaxEvents 1
$EventInfo | ForEach-Object {
$rv = New-Object PSObject | Select-Object Date, User, Action, Process, Reason, ReasonCode, Comment
$rv.Date = $_.TimeCreated
$rv.User = $_.Properties[6].Value
$rv.Process = $_.Properties[0].Value
$rv.Action = $_.Properties[4].Value
$rv.Reason = $_.Properties[2].Value
$rv.ReasonCode = $_.Properties[3].Value
$rv.Comment = $_.Properties[5].Value
$rv
} 
# ------------------------------------------------------ 
# E-Mail message configuration: from, to, subject, body
# ------------------------------------------------------ 
$message = new-object Net.Mail.MailMessage;
$message.From = $email_from_address;
foreach ($to in $email_to_addressArray) {
    $message.To.Add($to);
}
$message.Subject = $env:COMPUTERNAME + " has Rebooted"
$message.Body = "$env:COMPUTERNAME has rebooted at $($rv.Date) by $($rv.User) `r`nReason: $($rv.Reason) ($($rv.ReasonCode)) `r`nComment:$($rv.Comment) ";
 
# [...]
 
# ------------------------------------------------------ 
# Create SmtpClient object and send the e-mail message
# ------------------------------------------------------ 
$smtp = new-object Net.Mail.SmtpClient($email_smtp_host, $email_smtp_port);
$smtp.EnableSSL = $email_smtp_SSL;
$smtp.Credentials = New-Object System.Net.NetworkCredential($email_username, $email_password);
$smtp.send($message);
$message.Dispose();