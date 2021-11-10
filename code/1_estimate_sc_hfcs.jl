######################################
############################  PREAMBLE
######################################

### set working directory
cd("SET TO THE LOCATION OF THIS FOLDER")

### Set new environment
using Pkg
Pkg.activate("environments/sc-hfcs")

# ### add packages
# Pkg.add("Revise")
# Pkg.add("Random")
# Pkg.add("Mimi")
# Pkg.develop("MimiIWG")

### precompile
using Revise, Random, Mimi, MimiIWG

######################################
######################  SET PARAMETERS
######################################

seed = 42
N = 1
years = collect(2020:5:2060)
discount_rates = [0.02,0.025,0.03,0.05]

######################################
################################  DICE
######################################

# :HFC134a
Random.seed!(seed)
MimiIWG.run_scc_mcs(DICE, gas=:HFC134a, trials=N,
                    perturbation_years=years,
                    discount_rates=discount_rates,
                    domestic = true,
                    tables= true,
                    output_dir="data/hfc134a/dice")

######################################
################################  PAGE
######################################

# :HFC134a
Random.seed!(seed)
MimiIWG.run_scc_mcs(PAGE, gas=:HFC134a, trials=N,
                    perturbation_years=years,
                    discount_rates=discount_rates,
                    domestic = true,
                    tables= true,
                    output_dir="data/hfc134a/page")

######################################
################################  FUND
######################################

# :HFC134a
Random.seed!(seed)
MimiIWG.run_scc_mcs(FUND, gas=:HFC134a, trials=N,
                    perturbation_years=years,
                    discount_rates=discount_rates,
                    domestic = true,
                    tables= true,
                    output_dir="data/hfc134a/fund")

# ## END OF SCRIPT. Have a great day!
