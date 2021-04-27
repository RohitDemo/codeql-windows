# Prepare:
$codeql_runner_url = "https://github.com/github/codeql-action/releases/download/codeql-bundle-20210421/codeql-runner-win.exe"
$codeql_runner_output_file = "$PSScriptRoot\ignored\codeql-runner-win.exe"
$github_pat = ""

$github_repo_url = "https://github.com/RohitDemo/codeql-windows.git"
$github_host = $github_repo_url.split("/")[2]
$github_org = $github_repo_url.split("/")[3]
$github_repo_name = ($github_repo_url.split("/")[4]) -replace ".git",""
$github_repo = $github_org+ "/" +$github_repo_name
$git_commit = git rev-parse HEAD
$git_ref = git symbolic-ref HEAD
# For ADO Pipelines use these!
# github_host = "https://$($Build.Repository.Uri.split("/")[2])"
# github_org = $Build.Repository.Uri.split("/")[3]
# github_repo_name = ($Build.Repository.Uri.split("/")[4]) -replace ".git",""
# $github_repo = $github_org+ "/" +$github_repo_name
# $git_commit = $(Build.SourceVersion)
# $git_ref = $(Build.SourceBranch)

# DEBUG:
Write-Output "GitHubHost is $github_host"
Write-Output "GitHub Repo is $github_repo"
Write-Output "Commit is $git_commit"
Write-Output "Ref is $git_ref"

# 1. Download the Windows Runner
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

# 2. Initialise the Runner
& $codeql_runner_output_file init --repository $github_repo --github-url $github_host --github-auth $github_pat


# 2.1 COMPILE/BUILD
# & $codeql_runner_output_file autobuild
# OR
# Use you actual build steps here

# 3. Run the Analyse Step
& $codeql_runner_output_file analyze --repository $github_repo --github-url $github_host --github-auth $github_pat --commit $git_commit --ref $git_ref



