param(
    [switch]$Recreate
)

# Configurações
$VenvPath = ".\venv"
$RequirementsFile = "requirements.txt"

# Cores para logs
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Blue = "Blue"

function Write-Log {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] $Message" -ForegroundColor $Color
}

function Test-PythonInstalled {
    try {
        $null = Get-Command python -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-VenvExists {
    return Test-Path $VenvPath
}

function New-VirtualEnvironment {
    Write-Log "Criando ambiente virtual..." -Color $Blue
    
    try {
        Write-Log "Executando: python -m venv $VenvPath" -Color $Blue
        
        $output = cmd /c "python -m venv $VenvPath 2>&1"
        if ($LASTEXITCODE -ne 0) {
            Write-Log "Saída do comando: $output" -Color $Red
            throw "Falha ao criar ambiente virtual (código de saída: $LASTEXITCODE)"
        }
        Write-Log "Ambiente virtual criado com sucesso!" -Color $Green
    } catch {
        Write-Log "Erro ao criar ambiente virtual: $($_.Exception.Message)" -Color $Red
        exit 1
    }
}

function Remove-VirtualEnvironment {
    Write-Log "Removendo ambiente virtual existente..." -Color $Yellow
    
    try {
        Remove-Item -Path $VenvPath -Recurse -Force
        Write-Log "Ambiente virtual removido com sucesso!" -Color $Green
    } catch {
        Write-Log "Erro ao remover ambiente virtual: $($_.Exception.Message)" -Color $Red
        exit 1
    }
}

function Enable-VirtualEnvironment {
    Write-Log "Ativando ambiente virtual..." -Color $Blue
    
    $ActivateScript = Join-Path $VenvPath "Scripts\Activate.ps1"
    
    if (-not (Test-Path $ActivateScript)) {
        Write-Log "Script de ativação não encontrado!" -Color $Red
        exit 1
    }
    
    try {
        & $ActivateScript
        Write-Log "Ambiente virtual ativado com sucesso!" -Color $Green
    } catch {
        Write-Log "Erro ao ativar ambiente virtual: $($_.Exception.Message)" -Color $Red
        exit 1
    }
}

function Install-Dependencies {
    Write-Log "Instalando dependências..." -Color $Blue
    
    if (-not (Test-Path $RequirementsFile)) {
        Write-Log "Arquivo requirements.txt não encontrado!" -Color $Red
        exit 1
    }
    
    try {
        & "$VenvPath\Scripts\python.exe" -m pip install --upgrade pip
        if ($LASTEXITCODE -ne 0) {
            throw "Falha ao atualizar pip"
        }
        
        & "$VenvPath\Scripts\python.exe" -m pip install -r $RequirementsFile
        if ($LASTEXITCODE -ne 0) {
            throw "Falha ao instalar dependências"
        }
        
        Write-Log "Dependências instaladas com sucesso!" -Color $Green
    } catch {
        Write-Log "Erro ao instalar dependências: $($_.Exception.Message)" -Color $Red
        exit 1
    }
}

function Show-Summary {
    Write-Log "=====================================" -Color $Blue
    Write-Log "SETUP CONCLUÍDO COM SUCESSO!" -Color $Green
    Write-Log "=====================================" -Color $Blue
    Write-Log "Ambiente virtual: $VenvPath" -Color $Blue
    Write-Log "Para ativar o ambiente: .\venv\Scripts\Activate.ps1" -Color $Yellow
    Write-Log "Para desativar: deactivate" -Color $Yellow
    Write-Log "=====================================" -Color $Blue
}

# Início do script
Write-Log "============================================" -Color $Blue
Write-Log "CONFIGURAÇÃO DO AMBIENTE VIRTUAL PYTHON" -Color $Blue
Write-Log "============================================" -Color $Blue

# Verificar se Python está instalado
if (-not (Test-PythonInstalled)) {
    Write-Log "Python não está instalado ou não está no PATH!" -Color $Red
    exit 1
}

$pythonExe = (Get-Command python -ErrorAction Stop).Source
Write-Log "Localização: $pythonExe" -Color $Blue

# Verificar se precisa configurar versão do Python
$pythonVersion = cmd /c "python --version 2>&1"
if ($LASTEXITCODE -ne 0) {
    Write-Log "Erro ao obter versão do Python: $pythonVersion" -Color $Red
    Write-Log "Tentando configurar versão do Python com pyenv..." -Color $Yellow
    
    # Tentar configurar versão local
    $pyenvOutput = cmd /c "pyenv local 3.12.10 2>&1"
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Erro ao configurar versão local: $pyenvOutput" -Color $Red
        Write-Log "Tentando configurar versão global..." -Color $Yellow
        $pyenvOutput = cmd /c "pyenv global 3.12.10 2>&1"
        if ($LASTEXITCODE -ne 0) {
            Write-Log "Erro ao configurar versão global: $pyenvOutput" -Color $Red
            exit 1
        }
    }
    
    # Verificar novamente
    $pythonVersion = cmd /c "python --version 2>&1"
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Ainda não foi possível obter versão do Python: $pythonVersion" -Color $Red
        exit 1
    }
}

Write-Log "Python encontrado: $pythonVersion" -Color $Green

# Verificar se o ambiente virtual já existe
$venvExists = Test-VenvExists

if ($venvExists) {
    if ($Recreate) {
        Write-Log "Parâmetro -Recreate especificado. Recriando ambiente virtual..." -Color $Yellow
        Remove-VirtualEnvironment
        New-VirtualEnvironment
    } else {
        Write-Log "Ambiente virtual já existe. Use -Recreate para recriar." -Color $Yellow
    }
} else {
    Write-Log "Ambiente virtual não encontrado. Criando novo ambiente..." -Color $Yellow
    New-VirtualEnvironment
}

# Ativar ambiente virtual
Enable-VirtualEnvironment

# Instalar dependências
Install-Dependencies

# Mostrar resumo
Show-Summary

Write-Log "Script executado com sucesso!" -Color $Green