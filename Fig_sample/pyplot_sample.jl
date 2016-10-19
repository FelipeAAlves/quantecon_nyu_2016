
#== SIMPLE FIGURE ==#
pp_args = Dict{Symbol,Float64}(:alpha=>0.7, :linewidth=>2)

fig, ax = subplots(figsize=(12, 12))
ax[:set_title]("Marginal Propensities", fontsize = 22)
ax[:plot](x,y; pp_args...)
ax[:legend](loc="upper right",fontsize = 18, ncol=2)

###########################
#  Set the tick interval  #
###########################
Mx = matplotlib[:ticker][:MultipleLocator](0.1) # Define interval of major ticks
f = matplotlib[:ticker][:FormatStrFormatter]("%1.2f") # Define format of tick labels
ax[:xaxis][:set_major_locator](Mx) # Set interval of major ticks
ax[:xaxis][:set_major_formatter](f) # Set format of tick labels

###########################
#  Labels and Limits  #
###########################
ax[:set_xlabel]("Discretized income state", fontsize = 22)
ax[:set_xlim](minimum(λgrid), 0.0)
ax[:xaxis][:set_tick_params](labelsize = 22)

ax[:set_ylabel]("Discretized income state", fontsize = 22)
ax[:set_ylim](0.0, 0.5)
ax[:yaxis][:set_tick_params](labelsize = 22)


###########################
#  Different axis  #
###########################
fig = figure(figsize=(10,10))
p   = plot(Eλ, R, lw=3, alpha=0.6, label = "Aggregate Savings")
ax  = gca()

#== Set axis ==#
axis("tight")
ax[:spines]["top"][:set_visible](false) # Hide the top edge of the axis
ax[:spines]["right"][:set_visible](false) # Hide the right edge of the axis
#== Position axes ==#
ax[:spines]["left"][:set_position](("axes",0.3333))
# ax[:spines]["left"][:set_position]("center") # Move the right axis to the center
ax[:spines]["bottom"][:set_position]("center") # Most the bottom axis to the center
#ax[:spines]["left"][:set_smart_bounds](true)
ax[:xaxis][:set_ticks_position]("bottom") # Set the x-ticks to only the bottom
ax[:yaxis][:set_ticks_position]("left")

#== Set legend, etc ==#
# suptitle("Equilibrium", fontsize = 23)
ax[:set_ylim](0.99, 1.01)
ax[:yaxis][:set_label_coords](0.37, 0.975)
ax[:set_ylabel](L"$R_t$", fontsize = 18, rotation=0)
ax[:set_xlim](-0.3, 0.6)
ax[:xaxis][:set_label_coords](0.95, 0.475)
ax[:set_xlabel]("Aggregate Savings", fontsize = 18)
# ax[:set_title]("Equilibrium", fontsize = 20)
ax[:legend](loc="upper right",fontsize = 10, ncol=2)


#== bar Figure ==#
width = 0.25
fig, ax = subplots(figsize = (12,12))
ax[:bar](collect(1:n_e)      ,fr_const[:,1], width, color="blue", align="center", alpha=0.4, label = "Impatient")
ax[:bar](collect(1:n_e)+width,fr_const[:,2], width, color="red", align="center", alpha=0.4, label = "Patient")
ax[:axis]("tight")
ax[:set_xlabel]("Discretized income state", fontsize = 22)
ax[:xaxis][:set_tick_params](labelsize = 22)
ax[:yaxis][:set_tick_params](labelsize = 22)
ax[:set_ylabel]("Fraction of agents at the borr. limit", fontsize = 22)
ax[:legend](loc="upper right",fontsize = 18, ncol=2)

#== 3D figure ==#
p_args  = Dict{Symbol,Any}(:rstride=>2, :cstride=>2, :cmap=>ColorMap("Oranges"), :alpha=>0.7, :linewidth=>0.5)
pp_args = Dict{Symbol,Float64}(:alpha=>0.7, :linewidth=>2)
agrid, bgrid = meshgrid(a,b)

#== Consumption 3D ==#
cons_low = c[:,:,1]
fig = figure(figsize = (8,6))
ax = fig[:gca](projection="3d")
ax[:plot_surface](agrid, bgrid, cons_low; p_args...)
ax[:set_xlabel]("illiquid")
ax[:set_ylabel]("liquid")
ax[:legend]()
ax[:set_title]("Consumption")
fig[:show]()


#== Contour PLOT ==#
fig, ax = subplots(figsize = (8,6))
ax[:xaxis][:grid](true, zorder=0)
ax[:yaxis][:grid](true, zorder=0)
ax[:contourf](agrid, bgrid, dens, 5, alpha=0.6, cmap=ColorMap("jet"))
cs1 = ax[:contour](agrid, bgrid, dens, 5, colors="black",lw=2)
ax[:clabel](cs1, inline=1, fontsize=10)
ax[:set_xlabel]("illiquid")
ax[:set_ylabel]("liquid")
# ax[:set_xlim]([0,)
# ax[:set_ylim]([-2,10])
ax[:legend]()
fig[:show]()
