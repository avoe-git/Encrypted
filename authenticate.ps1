# This PowerShell script will prompt for Windows Hello authentication
# and return success or failure.

try {
    # Prompt for Windows Hello
    $credential = Get-Credential -Message "Please verify using Windows Hello"
    if ($credential -ne $null) {
        Write-Output "Authentication successful"
        exit 0
    } else {
        Write-Output "Authentication failed"
        exit 1
    }
} catch {
    Write-Output "Windows Hello authentication error"
    exit 1
}
