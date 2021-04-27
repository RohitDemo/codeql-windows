# Download the Runner

$codeql_runner_url = "https://github.com/github/codeql-action/releases/download/codeql-bundle-20210423/codeql-runner-win.exe"
$codeql_runner_output_file = "$PSScriptRoot\codeql-runner-win.exe"
try
{
    $Response = Invoke-WebRequest -Uri $codeql_runner_url -OutFile $codeql_runner_output_file
    $StatusCode = $Response.StatusCode
    Write-Output "Download completed successfully"
}
catch
{
    $StatusCode = $_.Exception.Response.StatusCode.value__
    Write-Output "Download Failed"
}

