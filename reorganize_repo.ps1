# Repository Reorganization Script
# IASS CubeSat Challenge - Final Cleanup
# Date: November 10, 2025

param(
    [switch]$DryRun = $false,
    [switch]$Backup = $true
)

$ErrorActionPreference = "Stop"
$rootPath = $PSScriptRoot

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "Repository Reorganization Script" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "[DRY RUN MODE] No files will be moved" -ForegroundColor Yellow
} else {
    Write-Host "[LIVE MODE] Files will be reorganized" -ForegroundColor Green
}

# Create backup if requested
if ($Backup -and -not $DryRun) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = Join-Path $rootPath "backup_$timestamp"
    Write-Host "Creating backup at: $backupPath" -ForegroundColor Yellow
    
    # Backup critical files
    $criticalFiles = @(
        "SatelliteDataAnalysis.ipynb",
        "EPS_Inference_Logic.ipynb",
        "NEPALISAT.xlsx",
        "RAAVANA.xlsx",
        "TSURU.xlsx",
        "UGUISU.xlsx"
    )
    
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    foreach ($file in $criticalFiles) {
        $srcPath = Join-Path $rootPath $file
        if (Test-Path $srcPath) {
            Copy-Item -Path $srcPath -Destination $backupPath -Force
            Write-Host "  Backed up: $file" -ForegroundColor Gray
        }
    }
}

# Helper function to move files
function Move-FileWithCheck {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Description = ""
    )
    
    $sourcePath = Join-Path $rootPath $Source
    $destPath = Join-Path $rootPath $Destination
    
    if (-not (Test-Path $sourcePath)) {
        Write-Host "  [SKIP] Not found: $Source" -ForegroundColor DarkGray
        return
    }
    
    if ($DryRun) {
        Write-Host "  [PLAN] $Source → $Destination" -ForegroundColor Cyan
        return
    }
    
    # Create destination directory
    $destDir = Split-Path -Parent $destPath
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    # Move file
    try {
        Move-Item -Path $sourcePath -Destination $destPath -Force
        if ($Description) {
            Write-Host "  [MOVED] $Description" -ForegroundColor Green
        } else {
            Write-Host "  [MOVED] $Source → $Destination" -ForegroundColor Green
        }
    } catch {
        Write-Host "  [ERROR] Failed to move $Source : $_" -ForegroundColor Red
    }
}

# Helper function to copy files
function Copy-FileWithCheck {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Description = ""
    )
    
    $sourcePath = Join-Path $rootPath $Source
    $destPath = Join-Path $rootPath $Destination
    
    if (-not (Test-Path $sourcePath)) {
        Write-Host "  [SKIP] Not found: $Source" -ForegroundColor DarkGray
        return
    }
    
    if ($DryRun) {
        Write-Host "  [PLAN] Copy $Source → $Destination" -ForegroundColor Cyan
        return
    }
    
    # Create destination directory
    $destDir = Split-Path -Parent $destPath
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }
    
    # Copy file
    try {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        if ($Description) {
            Write-Host "  [COPIED] $Description" -ForegroundColor Green
        } else {
            Write-Host "  [COPIED] $Source → $Destination" -ForegroundColor Green
        }
    } catch {
        Write-Host "  [ERROR] Failed to copy $Source : $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 1: Notebooks → notebooks/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "SatelliteDataAnalysis.ipynb" "notebooks/01_data_exploration_modeling.ipynb" "Data Analysis Notebook"
Move-FileWithCheck "EPS_Inference_Logic.ipynb" "notebooks/02_inference_deployment.ipynb" "Inference Logic Notebook"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 2: Data Files → data/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "NEPALISAT.xlsx" "data/NEPALISAT/NEPALISAT.xlsx" "NEPALISAT dataset"
Move-FileWithCheck "RAAVANA.xlsx" "data/RAAVANA/RAAVANA.xlsx" "RAAVANA dataset"
Move-FileWithCheck "TSURU.xlsx" "data/TSURU/TSURU.xlsx" "TSURU dataset"
Move-FileWithCheck "UGUISU.xlsx" "data/UGUISU/UGUISU.xlsx" "UGUISU dataset"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 3: Documentation → docs/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "SYNTHESIS_SUMMARY_NEXT_STEPS.md" "docs/SYNTHESIS_SUMMARY_NEXT_STEPS.md"
Move-FileWithCheck "COMPREHENSIVE_MODEL_SYNTHESIS.md" "docs/COMPREHENSIVE_MODEL_SYNTHESIS.md"
Move-FileWithCheck "UPDATED_STRATEGY.md" "docs/UPDATED_STRATEGY.md"
Move-FileWithCheck "CLEANUP_CHECKLIST.md" "docs/CLEANUP_CHECKLIST.md"
Move-FileWithCheck "deploy/LOGIC_VERIFICATION.md" "docs/LOGIC_VERIFICATION.md"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 4: Hardware Docs → hardware/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "deploy/CIRCUIT_DESIGN.md" "hardware/CIRCUIT_DESIGN.md"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 5: Reference PDFs → docs/references/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "MyPublication_IOSRJOURNAL.pdf" "docs/references/MyPublication_IOSRJOURNAL.pdf"
Move-FileWithCheck "applsci-12-08634-v2.pdf" "docs/references/applsci-12-08634-v2.pdf"
Move-FileWithCheck "IES-AESS-Challenge.pdf" "docs/references/IES-AESS-Challenge.pdf"
Move-FileWithCheck "doc1.pdf" "docs/references/doc1.pdf"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 6: Metrics CSVs → models/metrics/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

Move-FileWithCheck "deployment_manifest.csv" "models/metrics/deployment_manifest.csv"
Move-FileWithCheck "temporal_generalization_results.csv" "models/metrics/temporal_generalization_results.csv"
Move-FileWithCheck "multitarget_prediction_results.csv" "models/metrics/multitarget_prediction_results.csv"
Move-FileWithCheck "stage_comparison_avg_mae.csv" "models/metrics/stage_comparison_avg_mae.csv"
Move-FileWithCheck "stage_improvement_vs_stage1.csv" "models/metrics/stage_improvement_vs_stage1.csv"
Move-FileWithCheck "stage3_mae_by_panel_model.csv" "models/metrics/stage3_mae_by_panel_model.csv"
Move-FileWithCheck "stage3_rmse_by_panel_model.csv" "models/metrics/stage3_rmse_by_panel_model.csv"
Move-FileWithCheck "stage4_mae_by_panel_model.csv" "models/metrics/stage4_mae_by_panel_model.csv"
Move-FileWithCheck "stage4_rmse_by_panel_model.csv" "models/metrics/stage4_rmse_by_panel_model.csv"

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 7: Model Artifacts → models/training_artifacts/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Move all .pkl and metadata .json files from model_artifacts/
if (Test-Path (Join-Path $rootPath "model_artifacts")) {
    $modelFiles = Get-ChildItem -Path (Join-Path $rootPath "model_artifacts") -File
    foreach ($file in $modelFiles) {
        if ($file.Extension -in @(".pkl", ".json")) {
            Move-FileWithCheck "model_artifacts\$($file.Name)" "models\training_artifacts\$($file.Name)"
        }
    }
}

# Move model CSVs and thresholds from model_artifacts/
if (Test-Path (Join-Path $rootPath "model_artifacts")) {
    $metricFiles = Get-ChildItem -Path (Join-Path $rootPath "model_artifacts") -Filter "*.csv"
    foreach ($file in $metricFiles) {
        Move-FileWithCheck "model_artifacts\$($file.Name)" "models\metrics\$($file.Name)"
    }
}

# Move deployed models to training artifacts
if (Test-Path (Join-Path $rootPath "deploy\models")) {
    $deployedModels = Get-ChildItem -Path (Join-Path $rootPath "deploy\models") -Filter "*.pkl"
    foreach ($file in $deployedModels) {
        Move-FileWithCheck "deploy\models\$($file.Name)" "models\training_artifacts\$($file.Name)"
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 8: Model Config → models/config/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

if (Test-Path (Join-Path $rootPath "deploy\config")) {
    $configFiles = Get-ChildItem -Path (Join-Path $rootPath "deploy\config") -Filter "model_metadata_*.json"
    foreach ($file in $configFiles) {
        Move-FileWithCheck "deploy\config\$($file.Name)" "models\config\$($file.Name)"
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 9: Inference Runs → simulation/results/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

if (Test-Path (Join-Path $rootPath "runs")) {
    $runDirs = Get-ChildItem -Path (Join-Path $rootPath "runs") -Directory
    foreach ($dir in $runDirs) {
        if ($dir.Name -match "^eps_inference") {
            $sourcePath = Join-Path $rootPath "runs\$($dir.Name)"
            $destPath = Join-Path $rootPath "simulation\results\$($dir.Name)"
            
            if ($DryRun) {
                Write-Host "  [PLAN] Move runs\$($dir.Name) → simulation\results\$($dir.Name)" -ForegroundColor Cyan
            } else {
                if (-not (Test-Path (Join-Path $rootPath "simulation\results"))) {
                    New-Item -ItemType Directory -Path (Join-Path $rootPath "simulation\results") -Force | Out-Null
                }
                Move-Item -Path $sourcePath -Destination $destPath -Force
                Write-Host "  [MOVED] Inference run: $($dir.Name)" -ForegroundColor Green
            }
        }
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 10: Organize Figures → figures/subfolders/" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Stage comparison figures
if (Test-Path (Join-Path $rootPath "figures")) {
    $stageFigs = Get-ChildItem -Path (Join-Path $rootPath "figures") -Filter "*stage*.png"
    foreach ($fig in $stageFigs) {
        Move-FileWithCheck "figures\$($fig.Name)" "figures\stages\$($fig.Name)"
    }
    
    # Generalization figures
    $genFigs = @("temporal_generalization.png", "nepalisat_vs_raavana_comparison.png", "temporal_test_predictions_all_panels.png")
    foreach ($figName in $genFigs) {
        Move-FileWithCheck "figures\$figName" "figures\generalization\$figName"
    }
    
    # Deployment figures
    $deployFigs = Get-ChildItem -Path (Join-Path $rootPath "figures") -Filter "*raavana*.png"
    foreach ($fig in $deployFigs) {
        Move-FileWithCheck "figures\$($fig.Name)" "figures\deployment\$($fig.Name)"
    }
    
    $deployFigs2 = Get-ChildItem -Path (Join-Path $rootPath "figures") -Filter "inference_*.png"
    foreach ($fig in $deployFigs2) {
        Move-FileWithCheck "figures\$($fig.Name)" "figures\deployment\$($fig.Name)"
    }
    
    # Panel figures
    $panelFigs = Get-ChildItem -Path (Join-Path $rootPath "figures") -Filter "*panel*.png"
    foreach ($fig in $panelFigs) {
        if ($fig.Name -notmatch "stage") {
            Move-FileWithCheck "figures\$($fig.Name)" "figures\panels\$($fig.Name)"
        }
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "STEP 11: Clean up empty directories" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

if (-not $DryRun) {
    $emptyDirs = @(
        "model_artifacts",
        "runs",
        "deploy\models",
        "deploy\config"
    )
    
    foreach ($dir in $emptyDirs) {
        $dirPath = Join-Path $rootPath $dir
        if (Test-Path $dirPath) {
            $items = Get-ChildItem -Path $dirPath -Recurse
            if ($items.Count -eq 0) {
                Remove-Item -Path $dirPath -Recurse -Force
                Write-Host "  [REMOVED] Empty directory: $dir" -ForegroundColor Yellow
            }
        }
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "REORGANIZATION COMPLETE!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "This was a DRY RUN. Run again without -DryRun to apply changes." -ForegroundColor Yellow
} else {
    Write-Host "Files have been reorganized. Next steps:" -ForegroundColor Green
    Write-Host "  1. Add conclusions to notebooks" -ForegroundColor White
    Write-Host "  2. Create README.md" -ForegroundColor White
    Write-Host "  3. Review folder structure" -ForegroundColor White
    Write-Host "  4. Commit to Git" -ForegroundColor White
}
