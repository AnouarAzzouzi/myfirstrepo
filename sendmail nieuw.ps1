
# Version 2.0
# Copyright 2024 Anouar


$username = "powershell@sunnus.nl"
$topsecret = "8lRiHzXc" #never store passwords like this.
$password = ConvertTo-SecureString $topsecret -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

#SMTP Settings
$smtp = "smtp.sunnus.nl"
$port = 587

#Address
$to = "175862@student.horizoncollege.nl" # aanpassen!
$from = "powershell@sunnus.nl"

$status = "Down"
$serverName = "google server"
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$cause = "Stagaire heeft de server fout geconfigureerd"
$companyName = "HC-IT"
$lastChange = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Server Status Notification</title>
</head>
<body>
    <h1>Server Status Notification</h1>
    <p>Geachte gebruiker,</p>
    <p>Hier is de huidige status van de server:</p>
    <ul>
        <li>Status Server: $status</li>

        <li>Servernaam: $serverName</li>

        <li>Datum/Tijd: $dateTime</li>

        <li>Mogelijke oorzaak: $cause</li>

        <li>Laatste wijziging: $lastChange</li>
        
    </ul>
    <p>Met vriendelijke groet,</p>
    <p>Servicedesk Team</p>
</body>
</html>
"@

# for ($i = 1; $i -le 5 ; $i++) {
# }

# ^^ Dit is een spammer AFBLIJVEN ^^

Send-MailMessage -BodyAsHtml $htmlContent -To $to -Subject $subject -SmtpServer $smtp -From $from -Credential $psCred -Port $port

Write-Output "E-mail is verstuurd."


