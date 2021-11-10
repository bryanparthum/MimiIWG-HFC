# compute radiative forcing perturbations for 1 Mt of marginal HFC emissions
# based on a one box model for concentrations and a linear forcing fucntion



# ------------------------------------------------------------------------------
# options
# ------------------------------------------------------------------------------

# time horizon over which to compute the radiative forcing
horizon = 300

# radiative efficiency values to use ("re_ar4" or "re_fair")
re_col = "re_ar4"



# ------------------------------------------------------------------------------
# define functions
# ------------------------------------------------------------------------------

# run_pulse: calculates the concentraion and radiative forcing for a 1 Mt pulse
#
# inputs:
#   ghg:    specifies the species to run
#
# outputs:
#   ghg:    ghg species
#   t:      year since the emissions pulse occured
#   c:      concentration [ppb]
#   re:     radiative forcing [w/m^2]
#

run_pulse = function(ghg) {

  # create a container for the output
  out = data.frame(ghg=ghg,t=0:horizon,c=array(0,horizon+1),stringsAsFactors=F)
  
  # one box exponential decline for concentrations
  out$c = ghg_data$ppb_mt[ghg_data$ghg==ghg]*
          exp(-out$t/ghg_data$lifetime[ghg_data$ghg==ghg])
  
  # calculate radiative forcing
  out$rf = out$c*ghg_data[ghg_data$ghg==ghg,re_col]

  return(out[-1,])
  
}



# ------------------------------------------------------------------------------
# run the perturbations
# ------------------------------------------------------------------------------

# load the data of hfc lifetimes and radiative efficacy
ghg_data = read.csv("../data/hfc_data.csv",stringsAsFactors=F,skip=5)

# time horizon over which to compute the radiative forcing
horizon = 300

# molecular weight of air [g/mol]
mol_weight_air = 28.97

# mass of atmosphere [kg]
m_atmos = 5.1352e18 

# factors for converting from mt of emissions to ppb of concentration
ghg_data$ppb_mt = 1/(m_atmos/1e18*ghg_data$mol_weight/mol_weight_air)


# loop through each species in the data file and run the perturbation scenario
pulse = NULL
for (ghg in ghg_data$ghg)
  pulse = rbind(pulse,run_pulse(ghg))

# save the results
write.csv(pulse,"../data/ghg_radiative_forcing_perturbation.csv",row.names=F)



# ------------------------------------------------------------------------------
# plot the results
# ------------------------------------------------------------------------------

library(ggplot2)
library(scales)

# for comparison, see the ippc plot:
# https://archive.ipcc.ch/pdf/special-reports/sroc/Figures/f0207.pdf

p = ggplot(pulse)+
      geom_line(aes(x=t,y=rf,color=ghg),size=1)+
      labs(x="Years Since 1 Mt Emissions Pulse",
           y="Additional Radiative Forcing [w/m^2]")+
      guides(color=guide_legend(title="Species"))+
      scale_y_log10(limits=c(1e-8,1e-1),
                    breaks=trans_breaks("log10", function(x) 10^x),
                    expand=c(0,0))+
      scale_x_continuous(trans="log10",limits=c(1,1000),expand=c(0,0))+
      theme(axis.line.x      = element_line(colour="black"),
            axis.line.y      = element_line(colour="black"),
            panel.grid.minor = element_blank(),
            panel.border     = element_blank(),
            panel.background = element_blank(),
            legend.key       = element_blank(),
            legend.position  = c(.15,.3))+
      annotation_logticks()

print(p)

ggsave("../final/ghg_radiative_forcing_perturbation.png",device="png",width=8,height=6,
       dpi=300)
