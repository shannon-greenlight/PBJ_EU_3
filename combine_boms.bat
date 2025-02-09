@echo off
REM Check if both CSV files exist
if not exist bom\Digi-Key\PBJ_EU_full.csv (
    echo Warning: bom\Digi-Key\PBJ_EU_full.csv does not exist.
    exit /b
)

if not exist sub\bom\Digi-Key\sub_full.csv (
    echo Warning: sub\bom\Digi-Key\sub_full.csv does not exist.
    exit /b
)

echo Generating main BOM...
@call generate_boms.bat

cd sub
echo Generating sub BOM...
@call generate_boms.bat
cd ..

echo Combining BOMs...

py combine_boms.py

pause