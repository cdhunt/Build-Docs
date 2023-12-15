function Get-Description {
    param ($description, [string]$noDesc)

    $description = $description.Description.Text | Out-String
    $line = '{0}' -f (Get-Text $description $noDesc)

    return $line
}