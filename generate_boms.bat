@echo off

echo This creates BOM files for building the PBJ EU
echo It requires PBJ_EU.xml as an input. Make sure that it is up to date. Use the KiCAD schematic legacy BOM generator with the bom2grouped_csv.xsl plugin that's supplied with KiCAD.

set plugin_dir=C:\Users\shann\Dropbox\Python\BOM
set base_file=PBJ_EU

py "%plugin_dir%/bom_lcsc.py" "%base_file%.xml" "bom\LCSC\%base_file%_bom.csv"

rem py "%plugin_dir%/bom_other.py" "%base_file%.xml" "bom\Other\%base_file%_bom.csv"

py "%plugin_dir%/bom_digikey_split.py" "%base_file%.xml" "bom\Digi-Key\%base_file%_split.csv"

py "%plugin_dir%/bom_digikey_full.py" "%base_file%.xml" "bom\Digi-Key\%base_file%_full.csv"

if not errorlevel 1 echo Success!

pause