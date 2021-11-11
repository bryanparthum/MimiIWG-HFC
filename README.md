# The Social Cost of Hydroflourocarbons included in the 2021 Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act


This repo contains data and code for reproducing The Social Cost of Hydroflourocarbons  (SC-HFCs) included in the 2021 
"[Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act](https://www.epa.gov/climate-hfcs-reduction/proposed-rule-phasedown-hydrofluorocarbons-establishing-allowance-allocation)". 

The estimates of the SC-HFCs were estimated using [Mimi](https://www.mimiframework.org/) coupled with Resources for the Future's component [MimiIWG](https://www.rff.org/publications/data-tools/social-cost-of-carbon-computing-platform-models-from-the-iwg/) 

## Requirements

1. *Mimi* is free, open-source, and available for download [here](https://www.mimiframework.org/).
2. *R* is free, open-source, and available for download [here](https://www.r-project.org/).

## Included in this Repo

1. MimiIWG.jl - (too large for this repo but recovered from the following link) At the time this README was made and when the SC-HFC's were estimated, the repo located [here](https://github.com/bryanparthum/MimiIWG.jl/tree/HFC-implementation) is the Mimi package that will replace the MimiIWG package from the Mimi API. Drop this folder into your Mimi path, and use exactly as you would the MimiIWG folder
from the API (e.g., add to your environment with `] dev MimiIWG`, and precompile with `using MimiIWG`). 

2. Code - this folder contains the replication script for using MimiIWG, the necessary postprocessing code, and additional code for plotting the histograms. 

3. Data - This folder is currently empty, and will be the location of the output from `1_estimate_sc_hfcs.jl` and input to the other postprocessing code. 

4. Final - This folder contains the final numbers and histograms used to estimate the climate benefits in the 2021 Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act. 

## Additional Information

The raw output from the Mimi runs, once completed, will need to be dropped into the data folder under the appropriate gas and model combination folders, along with the discontinuity
results (i.e., the folder titled: "discontinuity_mismatch" in the Mimi output).

There are three postprocessing scripts.

1. `2_clean_discontinuities.R` - This script cleans the raw output from Mimi that identifies the years in which a temperature anomaly occured in each monte-carlo run 
and prepares them for use in the subequent script. This is consistent with the methods described in the 
[2016 TSD](https://www.epa.gov/sites/default/files/2016-12/documents/addendum_to_sc-ghg_tsd_august_2016.pdf) and applies them to all HFCs.

2. `3_clean_sc_hfcs.R` - This script cleans the raw output from the Mimi monte-carlo runs. It also pairs all of the discontinuities (temperature anomalies) estimated 
in the PAGE monte-carlo runs for all HFCs and replaces the values with missings. This is consistent with the methods described in the 
[2016 TSD](https://www.epa.gov/sites/default/files/2016-12/documents/addendum_to_sc-ghg_tsd_august_2016.pdf).

3. `4_clean_data_to_share.R` - This script simply compiles all the cleaned individual runs from the previous script and prepares the annual unrounded average SC-HFCs used to estimate the climate benefits in the 2021 "[Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act](https://www.epa.gov/climate-hfcs-reduction/proposed-rule-phasedown-hydrofluorocarbons-establishing-allowance-allocation)". 
