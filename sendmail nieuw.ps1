
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

# Certificaat aanmaken en signeren
$cert = New-SelfSignedCertificate -DnsName "MAXTERMUX" -CertStoreLocation "Cert:\LocalMachine\My"
Set-AuthenticodeSignature -FilePath "C:\Users\ishel\OneDrive\Documenten\send-mail" -Certificate $cert

# SIG # Begin signature block
# MIIFuQYJKoZIhvcNAQcCoIIFqjCCBaYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDXWMvZ4XfWjKp3
# M++dgz/7DzmeemA6PfaDhyl+/qaDkKCCAyIwggMeMIICBqADAgECAhAw8+WQSyql
# gEOwHTojBbHwMA0GCSqGSIb3DQEBCwUAMCcxJTAjBgNVBAMMHFBvd2VyU2hlbGwg
# Q29kZSBTaWduaW5nIENlcnQwHhcNMjQwNjA1MDc1MjMyWhcNMjUwNjA1MDgxMjMy
# WjAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxb4mMEuFaETJ68IXfSInwdxmuWDc
# nlUGYb/Ihhgg9bA6lY0+tGAp/3qgJy0frcAsxbGs50HlWdxZUjQ1ltjVWRHYD+X0
# 5Cl0tP4XGLJYNi/23LdhFX+95OUYI5RxCkhUoA9a3L9AaPTzbVEABS4sj0hC7W+v
# joPkGnbvZemo1eHEFybYgmHlAqFlSXSUJIRsIJwEw9Vzo8PM/mWEaHHCixxrHP5u
# OXz8V1F9lM4swJofI7JdEtX9SEpHIkTMTj8F8+tK4xlM2kxpYXxPY7erKznDRiLQ
# OhyANpUu1tD2kpDrGu9vFBJce31J2VTeXkmGcGx8vq9YR/F3qJsAZ0X7cQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFKx+z+nPpuFaumrilpB8inTzrweYMA0GCSqGSIb3DQEBCwUAA4IBAQClZo5M
# ukgrVq6GLoctaO6qIHPn5CxnGXWeOHqYd8ut2DpdM9azO/jobPrByZ7UQ7RWkom+
# p3zXlr/bbJ1fc9zvzlkMaJLzEQyxdzNOYV8SkItqSk33O/z6rAjFD3g5Z98zieMN
# FcdOmckRq+eayhgu3sDoQONRbZw5KwkLP7dGlGehRT8Ep/97h8xs7+D1cY/oFYBX
# nTNAs6Nv3PyvRYOMRRatAWMfQdHHvZ7AlJfyjXe/hehn8J/1Ju9/CaNAmMizUtoe
# O7U2S5AWSVRoMXwwU0aExZZ/PaC+wpJinmQVosEYoDMnSq25JV1ElTpsfTVyGJol
# GsCKARiJmnznIkhmMYIB7TCCAekCAQEwOzAnMSUwIwYDVQQDDBxQb3dlclNoZWxs
# IENvZGUgU2lnbmluZyBDZXJ0AhAw8+WQSyqlgEOwHTojBbHwMA0GCWCGSAFlAwQC
# AQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZI
# hvcNAQkEMSIE
