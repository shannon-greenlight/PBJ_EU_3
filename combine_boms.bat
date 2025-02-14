@echo off
REM Check if both CSV files exist
echo This creates bom\Digi-Key\PBJ_EU_combined.csv for building the PBJ EU given pre-assembled boards from JLCPCB.
echo It requires PBJ_EU.xml and sub\PBJ_EU.xml as an inputs. Make sure that these files are up to date.
echo.
echo Use the KiCAD schematic legacy BOM generator with the bom2grouped_csv.xsl plugin that's supplied with KiCAD.
echo.

if not exist bom\Digi-Key\PBJ_EU_split.csv (
    echo Warning: bom\Digi-Key\PBJ_EU_split.csv does not exist.
    exit /b
)

if not exist sub\bom\Digi-Key\sub_split.csv (
    echo Warning: sub\bom\Digi-Key\sub_split.csv does not exist.
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