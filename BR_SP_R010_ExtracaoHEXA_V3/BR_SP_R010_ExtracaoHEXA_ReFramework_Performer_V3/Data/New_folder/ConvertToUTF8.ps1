Param(
    $Path
    )


(Get-Content -Path $Path) | Set-Content -Path $Path -Encoding UTF8