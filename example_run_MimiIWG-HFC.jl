## first clone the MimiIWG-HFC repo (e.g., git clone https://github.com/bryanparthum/MimiIWG-HFC.git)
## then navigate in the Julia REPL to the folder where you cloned the repo
## using cd("location of the MimiIWG-HFC directory (folder)")

## get package 
using Pkg

## confirm you are in the folder
pwd()

## activate
Pkg.activate(".")

## instantiate
Pkg.instantiate()

## check status
Pkg.status()

## precompile and add packages to the namespace
using Revise, Random, Mimi, MimiIWG

## test before making any changes
Random.seed!(42)
MimiIWG.run_scc_mcs(DICE, 
                    gas                = :HFC23, 
                    trials             = 2,
                    perturbation_years = [2020],
                    discount_rates     = [0.02],
                    domestic           = true,
                    tables             = true,
                    output_dir         = "output/hfc23")

## if everything works, dev a version of MimiIWG to make changes to the radiative forcings
Pkg.develop("MimiIWG")

## check status to confirm that Julia is now being pointed to the dev folder
Pkg.status() 

## now edit the pakage as necessary for your analysis (radiative forcings, etc.)