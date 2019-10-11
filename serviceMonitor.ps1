# Created by: Manusha Amal
# Date: 10/11/2019
# Description: Check Win Service to see if it is stop then send an email 
# Please change the $serviceName = "ServiceName" to your service need to monitor
# Please change the $sendemailaddress to Sender's mail address
# Please change the $destemailaddress to Receiver's mail address
# Here I am using gmail to smtp host. You can change whatever you want

 $sendemailaddress = "sendermailaddress@whatever.com"
 $destemailaddress = "Receivermailaddress@whatever.com"
 $serviceName = "ServiceName"
 
 $service = Get-Service | Where-Object { $_.Name -eq $serviceName }
 write-host "Service Status is" $service.status  
 
 if ($service.status -eq "Stopped")
 {
$encryptedpw = Get-Content .\securepassword.txt
$password = ConvertTo-SecureString -String $encryptedpw
$dateString = get-date   
$EmailFrom = $sendemailaddress
$EmailTo = $destemailaddress 
$Subject = "Service " + $serviceName + " is " + $service.status 
$Body = ([string]$dateString) + " Service " + $serviceName + " is " + $service.status 
$SMTPServer = "smtp.gmail.com" 
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
$SMTPClient.EnableSsl = $true 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($sendemailaddress, $password); 
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
$dateString = get-date

  #Starting the service	
  #Start-Service $serviceName
    
 }