#!/bin/pwsh
param($TargetParam = "", $ProtoPortsParam = "")

# sends tcp packet
function Tcp-Send
{
	param ( [string]$Computer, [int]$Port )
	$Test = new-object Net.Sockets.TcpClient
	( $Test.ConnectAsync( $Computer, $Port ) ).AsyncWaitHandle.WaitOne( 100 ) | Out-Null
}

# sends udp packet
function Udp-Send
{
	param ( [string]$Computer, [int]$Port )
	$Test = new-object Net.Sockets.UdpClient
	$Test.SendAsync( 100, 1, $Computer, $Port ) | Out-Null
}

# split name and ssh port from first parameter
$TargetName = $TargetParam -split ":" | Select-Object -First 1
$TargetSSHPort = $TargetParam -split ":" | Select-Object -Last 1

# split Proto:Port pairs from second parameter
$ProtoPorts = $ProtoPortsParam -split ","
Foreach ($ProtoPort in $ProtoPorts) {

	# split Proto:Port pairs apart
	$Proto = $ProtoPort -split ":" | Select-Object -First 1
	$Port = $ProtoPort -split ":" | Select-Object -Last 1
	Write-Host "knocking: "$TargetName":"$Proto":"$Port

	# send tcp or udp packets - may need to add 'Start-Sleep 1' (or attempt multiple times) because some packets may arrive before others
	If ($Proto -eq "tcp"){
		Tcp-Send $TargetName $Port
	}
	Elseif ($Proto -eq "udp"){
		Udp-Send $TargetName $Port
	}
}

# Short delay for allowing knock target to open
Start-Sleep 3

# Connect with PuTTY
$Putty = "C:\Program Files\PuTTY\putty.exe"
$PuttyArgs = "-ssh $TargetName -P $TargetSSHPort"
Start-Process -FilePath $Putty $PuttyArgs 
