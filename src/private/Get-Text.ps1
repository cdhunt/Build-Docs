function Get-Text {
    param ([string]$text, [string]$default)

    $text = $text.Trim()
    if ([string]::IsNullOrEmpty($text)) {
        if ([string]::IsNullOrEmpty($default)) {
            $default = 'No description'
        }
        return $default
    }
    return $text
}