<#
.SYNOPSIS
	Domain name WhoIs

.DESCRIPTION
	Performs a domain name lookup and returns information such as domain availability (creation and expiration date), domain ownership, name servers, etc..

.PARAMETER domain
	Specifies the domain name (enter the domain name without http:// and www (e.g. - cnn.com))

.EXAMPLE
	WhoIs -domain cnn.com 
	whois cnn.com
#>


param ([Parameter(Mandatory=$True, HelpMessage='Please enter domain name (e.g. microsoft.com)')][string]$domain
        )

Write-Host "Connecting to Web Services URL..." -ForegroundColor Green
try 
    {
    #Retrieve the data from web service WSDL
    If ($whois = New-WebServiceProxy -uri "http://www.webservicex.net/whois.asmx?WSDL") 
        {
        Write-Host "Ok" -ForegroundColor Green
        }
    else 
        {
        Write-Host "Error" -ForegroundColor Red
        }
    Write-Host "Gathering $domain data..." -ForegroundColor Green
    #Return the data
    (($whois.getwhois("=$domain")).Split("<<<")[0])
    } 
    catch 
        {
        Write-Host "Please enter valid domain name (e.g. microsoft.com)." -ForegroundColor Red
        }
     