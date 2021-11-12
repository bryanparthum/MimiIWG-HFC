# The Social Cost of Hydroflourocarbons included in the 2021 Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act


This repo contains data and code for reproducing The Social Cost of Hydroflourocarbons  (SC-HFCs) included in the 2021 
"[Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act](https://www.epa.gov/climate-hfcs-reduction/proposed-rule-phasedown-hydrofluorocarbons-establishing-allowance-allocation)". 

The estimates of the SC-HFCs were estimated using [Mimi](https://www.mimiframework.org/) coupled with Resources for the Future's component [MimiIWG](https://www.rff.org/publications/data-tools/social-cost-of-carbon-computing-platform-models-from-the-iwg/) 

## Requirements

1. *Mimi* is free, open-source, and available for download [here](https://www.mimiframework.org/).
2. *R* is free, open-source, and available for download [here](https://www.r-project.org/).

## Included in this Repo

1. code - this folder contains the replication script for using MimiIWG, the necessary postprocessing code, and additional code for plotting the histograms. 

2. data - This folder is the output folder from `1_estimate_sc_hfcs.jl` in the form of the `hfc134a` subfolder as created by that script, as well as input to the other postprocessing code: `ghg_radiative_forcing_perturbation.csv` and `hfc_data.csv`. 

3. final - This folder contains the final numbers used to estimate the climate benefits in the 2021 Phasedown of Hydrofluorocarbons: Establishing the Allowance Allocation and Trading Program under the AIM Act. 

## Running the Scripts

Begin by downloading the latest version of the [julia language](https://julialang.org/downloads/), and then clone this repository to your local machine with

```
git clone https://github.com/bryanparthum/MimiIWG-HFC.git
```

If you are running these scripts for the first time you'll need to do the following. If not this should be taken care of for you in "core/1_estimate_sc_hfcs.jl", although it won't hurt to do this explicitly.

After opening your julia REPL and navigating to this folder, you may activate the environments and thus obtain the exact package versions you need, either using the `]` shortcut to enter the package REPL, or the `Pkg` module, followed by the `activate .` command and a one time call to `instantiate`.

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate() 
```
or type `]` to enter the Pkg REPL (you will see the text before your cursor change color and say `pkg>` instead of `julia>`) and follow with:
```julia
activate .
instantiate
```
then press delete/backspace to exit the Pkg REPL.

Now you may run the main script with
```julia
include("code/1_estimate_sc_hfcs.jl")
```
and proceed with the postprocessing scripts from there!

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
