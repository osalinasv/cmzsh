if (-NOT $args[0]) {
	Write-Output "Target dir not specified"
	exit
}

$targetDir = $args[0]

if (-NOT (Test-Path $targetDir -PathType Container)) {
	Write-Output "Target dir does not exist"
	exit
}

Get-ChildItem $(Get-Location) -Filter "cmzsh_*.lua" | % {
	$targetPath = "$($targetDir)/$($_.Name)"

	if (Test-Path $targetPath) { Remove-Item $targetPath }
	New-Item -Path $targetPath -ItemType SymbolicLink -Value $_.FullName
}
