
function ShowBanner {
    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
    $PSDefaultParameterValues['Get-Content:Encoding'] = 'utf8'
    Clear-Host
    Write-Host '
-------------------------------------------------------------------------------------------------    
|                 ____ ___ _____     ____  _   _ _     _            _    _     _                |
|                / ___|_ _|_   _|   |  _ \| | | | |   | |          / \  | |   | |               |
|               | |  _ | |  | |     | |_) | | | | |   | |         / _ \ | |   | |               |
|               | |_| || |  | |     |  __/| |_| | |___| |___     / ___ \| |___| |___            |
|                \____|___| |_|     |_|    \___/|_____|_____|   /_/   \_\_____|_____|           |
|                                                                                               |
|               v1.0                                                                            |
|               Victor Hugo Marega                                                              |
-------------------------------------------------------------------------------------------------
'
    Start-Sleep -Seconds 1.5
}

function RequestPath {
    $EnterPath = Read-Host "`nInforme a pasta de repositorios GIT"
    return $EnterPath
}

function ConfirmPath($Path) {
    Write-Host "`nO caminho escolhido foi: $Path" 
    $Option = Read-Host "`nDeseja continuar? S/N"
    return $Option
}

function RequestBranch {
    $EnterBranch = Read-Host "`nInforme a branch que sera definida em todos os projetos"
    return $EnterBranch
}

function ConfirmBranch($Branch) {
    Write-Host "`nA branch escolhida foi: $Branch" 
    $OptionB = Read-Host "`nDeseja continuar? S/N"
    return $OptionB
}

function PullAllRepos($DirRepoPath) {
    Write-Host ""`n`n`n
    Set-Location $DirRepoPath
    $Folders = @(Get-ChildItem -Path $DirRepoPath)
    foreach ($Folder in $Folders) {
        Write-Host $Folder
        Set-Location $Folder
        git checkout $RequestBranch
        git pull
        Start-Sleep -Seconds 1
        Set-Location ..
    }
    Write-Host "`n`nTODOS OS REPOSITORIOS FORAM ATUALIZADOS!"
}

function StartScript {
    $StartOP = 0
    ShowBanner
    do {
        $RequestPath = RequestPath
        $SelectedOP = ConfirmPath($RequestPath)
        if(
            $SelectedOP -eq "S" -or
            $SelectedOP -eq "s" -or 
            $SelectedOP -eq "sim" -or 
            $SelectedOP -eq "Sim" -or 
            $SelectedOP -eq "Y" -or
            $SelectedOP -eq "y" -or
            $SelectedOP -eq "Yes" -or
            $SelectedOP -eq "yes"    
           ) {
            $RequestBranch = RequestBranch
            $SelectedOPB = ConfirmBranch($RequestBranch)
                if(
                    $SelectedOPB -eq "S" -or
                    $SelectedOPB -eq "s" -or 
                    $SelectedOPB -eq "sim" -or 
                    $SelectedOPB -eq "Sim" -or 
                    $SelectedOPB -eq "Y" -or
                    $SelectedOPB -eq "y" -or
                    $SelectedOPB -eq "Yes" -or
                    $SelectedOPB -eq "yes"    
                ) {
                    $StartOP = 1
                    PullAllRepos($RequestPath)
                    Read-Host -Prompt "`n`nAperte ENTER para finalizar"
                }
        }
    } while ($StartOP -eq 0)
}

StartScript
