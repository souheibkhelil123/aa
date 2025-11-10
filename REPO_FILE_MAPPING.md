# Complete Repository File Mapping

## Current Location → Target Location

### Root Level Files
```
CURRENT                                  → TARGET
================================================================================
README.md                                → README.md (create new)
.gitignore                              → .gitignore (create)
LICENSE                                 → LICENSE (create)
```

### Documentation Files → docs/
```
SYNTHESIS_SUMMARY_NEXT_STEPS.md         → docs/SYNTHESIS_SUMMARY_NEXT_STEPS.md
COMPREHENSIVE_MODEL_SYNTHESIS.md        → docs/COMPREHENSIVE_MODEL_SYNTHESIS.md
UPDATED_STRATEGY.md                     → docs/UPDATED_STRATEGY.md
CLEANUP_CHECKLIST.md                    → docs/CLEANUP_CHECKLIST.md
deploy/LOGIC_VERIFICATION.md            → docs/LOGIC_VERIFICATION.md
deploy/CIRCUIT_DESIGN.md                → hardware/CIRCUIT_DESIGN.md
```

### Reference PDFs → docs/references/
```
MyPublication_IOSRJOURNAL.pdf           → docs/references/MyPublication_IOSRJOURNAL.pdf
applsci-12-08634-v2.pdf                 → docs/references/applsci-12-08634-v2.pdf
IES-AESS-Challenge.pdf                  → docs/references/IES-AESS-Challenge.pdf
doc1.pdf                                → docs/references/doc1.pdf
Intégration-de-lIA-Embarquée*.pptx     → docs/references/Edge_AI_MCU_Integration.pptx
```

### Notebooks → notebooks/
```
SatelliteDataAnalysis.ipynb             → notebooks/01_data_exploration_modeling.ipynb
EPS_Inference_Logic.ipynb               → notebooks/02_inference_deployment.ipynb
```

### Data Files → data/
```
NEPALISAT.xlsx                          → data/NEPALISAT/NEPALISAT.xlsx
RAAVANA.xlsx                            → data/RAAVANA/RAAVANA.xlsx
TSURU.xlsx                              → data/TSURU/TSURU.xlsx
UGUISU.xlsx                             → data/UGUISU/UGUISU.xlsx
```

### Metrics CSVs → models/metrics/
```
deployment_manifest.csv                 → models/metrics/deployment_manifest.csv
temporal_generalization_results.csv     → models/metrics/temporal_generalization_results.csv
multitarget_prediction_results.csv      → models/metrics/multitarget_prediction_results.csv
stage_comparison_avg_mae.csv            → models/metrics/stage_comparison_avg_mae.csv
stage_improvement_vs_stage1.csv         → models/metrics/stage_improvement_vs_stage1.csv
stage3_mae_by_panel_model.csv          → models/metrics/stage3_mae_by_panel_model.csv
stage3_rmse_by_panel_model.csv         → models/metrics/stage3_rmse_by_panel_model.csv
stage4_mae_by_panel_model.csv          → models/metrics/stage4_mae_by_panel_model.csv
stage4_rmse_by_panel_model.csv         → models/metrics/stage4_rmse_by_panel_model.csv

model_artifacts/stage*.csv              → models/metrics/ (all stage CSVs)
model_artifacts/thresholds_*.json       → models/metrics/ (all thresholds)
```

### Model Artifacts → models/training_artifacts/
```
model_artifacts/*.pkl                   → models/training_artifacts/*.pkl
model_artifacts/*.json (metadata)       → models/training_artifacts/*.json
deploy/models/*.pkl                     → models/training_artifacts/*.pkl
```

### Model Config → models/config/
```
deploy/config/model_metadata_*.json     → models/config/model_metadata_*.json
```

### Generated C Code → deploy/c_code/
```
deploy/c_code/power_model.c             → deploy/c_code/power_model.c (keep)
deploy/c_code/voltage_model.c           → deploy/c_code/voltage_model.c (keep)
```

### STM32 Firmware → deploy/stm32_package/
```
deploy/stm32_package/eps_main_deployment.c     → deploy/stm32_package/eps_main_deployment.c (keep)
deploy/stm32_package/eps_main_example.c        → deploy/stm32_package/eps_main_example.c (keep)
deploy/stm32_package/eps_protection_final.c    → deploy/stm32_package/eps_protection_final.c (keep)
deploy/stm32_package/eps_protection_final.h    → deploy/stm32_package/eps_protection_final.h (keep)
deploy/stm32_package/eps_bias_corrector.h      → deploy/stm32_package/eps_bias_corrector.h (keep)
deploy/stm32_package/eps_p2_quantile.h         → deploy/stm32_package/eps_p2_quantile.h (keep)
deploy/stm32_package/eps_features.c            → deploy/stm32_package/eps_features.c (keep)
deploy/stm32_package/eps_model_config.h        → deploy/stm32_package/eps_model_config.h (keep)
deploy/README_DEPLOYMENT.md                    → deploy/README_DEPLOYMENT.md (keep)
```

### Simulation/Inference Results → simulation/results/
```
runs/eps_inference_*/                   → simulation/results/eps_inference_*/
```

### Figures → figures/
```
figures/*.png                           → figures/*.png (reorganize by subfolder)
figures/synthesis/*.png                 → figures/synthesis/*.png (keep)

Subfolders to create:
- figures/stages/          (stage comparison plots)
- figures/generalization/  (cross-satellite, temporal)
- figures/deployment/      (RAAVANA, inference)
- figures/panels/          (per-panel analysis)
- figures/synthesis/       (comprehensive dashboards)
```

### Scripts (Keep at Root)
```
generate_voltage_model_c.py             → generate_voltage_model_c.py (keep)
generate_synthesis_visualizations.py    → generate_synthesis_visualizations.py (keep)
```

---

## Files to Create

### New Documentation
```
docs/system_architecture.md             → Block diagram, dual-layer protection
docs/validation_results.md              → Cross-satellite testing summary
hardware/BOM.csv                        → Component bill of materials
hardware/schematics/README.md           → Schematic documentation
```

### New Root Files
```
README.md                               → Repository overview
.gitignore                              → Python, STM32, IDE ignores
LICENSE                                 → MIT or appropriate license
```

---

## Folder Structure After Organization

```
cubesat-solar-fdir/
├── README.md
├── .gitignore
├── LICENSE
├── generate_voltage_model_c.py
├── generate_synthesis_visualizations.py
│
├── docs/
│   ├── SYNTHESIS_SUMMARY_NEXT_STEPS.md
│   ├── COMPREHENSIVE_MODEL_SYNTHESIS.md
│   ├── UPDATED_STRATEGY.md
│   ├── CLEANUP_CHECKLIST.md
│   ├── LOGIC_VERIFICATION.md
│   ├── system_architecture.md (NEW)
│   ├── validation_results.md (NEW)
│   └── references/
│       ├── MyPublication_IOSRJOURNAL.pdf
│       ├── applsci-12-08634-v2.pdf
│       ├── IES-AESS-Challenge.pdf
│       ├── doc1.pdf
│       └── Edge_AI_MCU_Integration.pptx
│
├── hardware/
│   ├── CIRCUIT_DESIGN.md
│   ├── BOM.csv (NEW)
│   └── schematics/
│       └── README.md (NEW)
│
├── data/
│   ├── NEPALISAT/
│   │   └── NEPALISAT.xlsx
│   ├── RAAVANA/
│   │   └── RAAVANA.xlsx
│   ├── TSURU/
│   │   └── TSURU.xlsx
│   └── UGUISU/
│       └── UGUISU.xlsx
│
├── models/
│   ├── training_artifacts/
│   │   └── [all .pkl and metadata .json files]
│   ├── config/
│   │   └── model_metadata_*.json
│   └── metrics/
│       ├── deployment_manifest.csv
│       ├── temporal_generalization_results.csv
│       ├── multitarget_prediction_results.csv
│       ├── stage_comparison_avg_mae.csv
│       ├── stage_improvement_vs_stage1.csv
│       ├── stage*_mae_by_panel_model.csv
│       ├── stage*_rmse_by_panel_model.csv
│       └── thresholds_*.json
│
├── notebooks/
│   ├── 01_data_exploration_modeling.ipynb
│   └── 02_inference_deployment.ipynb
│
├── deploy/
│   ├── README_DEPLOYMENT.md
│   ├── c_code/
│   │   ├── power_model.c
│   │   └── voltage_model.c
│   └── stm32_package/
│       ├── eps_main_deployment.c
│       ├── eps_main_example.c
│       ├── eps_protection_final.c
│       ├── eps_protection_final.h
│       ├── eps_bias_corrector.h
│       ├── eps_p2_quantile.h
│       ├── eps_features.c
│       └── eps_model_config.h
│
├── simulation/
│   └── results/
│       └── eps_inference_*/
│           ├── inference_report.json
│           ├── power_predictions.csv
│           └── voltage_predictions.csv
│
└── figures/
    ├── stages/
    │   ├── stage_comparison_all_models.png
    │   └── per_panel_stage_comparison_randomforest.png
    ├── generalization/
    │   ├── temporal_generalization.png
    │   ├── nepalisat_vs_raavana_comparison.png
    │   └── temporal_test_predictions_all_panels.png
    ├── deployment/
    │   ├── raavana_deployment_simulation.png
    │   ├── raavana_deployment_convergence.png
    │   └── inference_test_+X.png
    ├── panels/
    │   └── power_timeseries_*.png
    └── synthesis/
        ├── comprehensive_evaluation_dashboard.png
        ├── stage_progression_comparison.png
        ├── panel_specific_performance.png
        ├── multitarget_performance.png
        ├── resource_requirements.png
        └── cross_satellite_deployment.png
```

---

## Total Files: ~430 → Organized into ~180 meaningful files
