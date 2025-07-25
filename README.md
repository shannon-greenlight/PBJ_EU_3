# The PBJ EU
The PBJ EU is a hardware development system for Eurorack synthesizers

Features:
- 800 point solderless proto board
- 4 switched 3.5mm jacks.
- Tip and Switch signals are routed from the jacks to the wiring connector.
- +/- 12V and adjustable A and B power rails are routed to the wiring connector.
- LED monitors for each jack. Red indicates positive voltage. Green indicates negative.
- 2 Test points per jack gives convenient access for probing and injecting signals.
- 2 Large Ground connection points are excellent for attaching alligator clips.
- 3 MULT switches connect jack 1 to 2, jack 2 to 3 or jack 3 to 4.
- Power is switched.
- Power indicators show the status of all power rails.
- 22 HP wide.
- Ready when you are. Everything you need with no pre-setup required!

# Making Changes
The process of making changes usually starts with altering the schematic followed by other actions as required.
This requires a properly configured KiCAD installation. Download the KiCAD [repo](https://github.com/shannon-greenlight/KiCAD) and follow the instructions in the README to install.
When the system is configured follow the steps outlined below. Some steps are optional depending on what has changed.

These procedures have been optimized for use with Digi-Key and JLCPCB. They should be a good starting point for use with other vendors.

- Update schematic
	- Update revision in File->Page Settings
	- Plot pdf version of schematic.
- If any parts have changed, Update BOMs
	- From KiCAD Schematic Editor, run Tools->Generate Legacy Bill of Materials using bom2grouped_csv.xsl
		- bom2grouped_csv.xsl is found in the Greenface KiCAD repo.
		- Here is a sample command line: xsltproc -o "%O.csv" "C:\Users\shann\Dropbox\KiCAD\bom2grouped_csv.xsl" "%I"
		- This creates a .csv and an xml file. The xml file is used in the next step.
	- Run _combine_boms.bat_
		- This creates the following .csv files
			- BOM\Digi-Key\PBJ_EU_combined.csv (all components, both boards combined)
			- BOM\Digi-Key\PBJ_EU_full.csv (all components, top board)
			- BOM\Digi-Key\PBJ_EU_split.csv (just components on top board that are not found in LCSC BOM)
			- BOM\LCSC\PBJ_EU_bom.csv (just components on top board to be assembled by JLCPCB)
			- sub\BOM\Digi-Key\PBJ_EU_full.csv (all components, sub board)
			- sub\BOM\Digi-Key\PBJ_EU_split.csv (just components on sub board that are not found in LCSC BOM)
			- sub\BOM\LCSC\PBJ_EU_bom.csv (just components on sub board to be assembled by JLCPCB)
		- combine_boms.bat requires Python and the Greenface Python [libraries](https://github.com/shannon-greenlight/PYTHON_BOM) to be installed
			- Place the Greenface Python folder in a convienient place on your computer and set the variable %plugin_dir% to point to that folder location.
			- Python is invoked as 'py' in the batch file. This may need to be changed depending on your Python installation.
- Update layout if required
	- Update revision in File->Page Settings
	- Plot the Gerber files
		- Set the output directory to _fab\gerber\\_
		- Make sure to Generate Drill Files
		- Create a zip archive of the Gerber files. (This is required by JLCPCB)
			- Use Windows Send To Compressed Folder. Rename the resulting file to PBJ_EU_gerbers.zip
			- Alternatively, use zip_gerbers.bat
			- zip_gerbers.bat requires 7z.exe
			- Edit this file if 7z.exe is installed somewhere other than C:\Program Files\7-Zip
	- Create the pick-and-place files
		- From KiCAD PCB Editor, run File->Fabrication Outputs->Component Placement
		- Set the output directory to _fab\pos\\_
		- This creates the files used by the next step
		- Update PBJ_EU_cpl.xlsx
			- PBJ_EU_cpl.xlsx uses Excel Queries to convert pos\PBJ_EU-top-pos.csv into a format compatible with JLCPCB
			- Excel requires an absolute path to the source folder of the data. Edit the query to enter the path to your project.
			- *note: This process does not produce a perfect placement file due to differences in how KiCAD and JLCPCB orient components. However, JLCPCB is able to use the file without problems. So, even if the placement looks wrong when specifying the build, they will use the file and produce correct boards.
			- **note: There is probably a KiCAD plugin available that does a better job. The user is encouraged to try this route and report the results back.
- Upload to JLCPCB
	- JLCPCB requires the following files:
		- fab\PBJ_EU_gerbers.zip
		- fab\PBJ_EU_cpl.xlsx (only needed for assembly)
		- bom\LCSC\PBJ_EU_bom.csv (only needed for assembly)
