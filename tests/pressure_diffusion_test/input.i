################################################################################################################
# A simple themo-poro-elastic example for iceland injection
# injection of 50 degree water into 500x500x500 m^3 reservoir at rate of 24Kg/s (using Trap integration rule)
# initial reservoir pressure & temperature are 10MP and 200, respectively
# initial vetitial stress is set to be 25MP (~1km over burden), and initial horizontal confining stress is 12.5MP
#
# !! a relatively large linear tolerance is used since mechanical deformation reach equilibrium very quickly
# !! the pressure also reach near steady state fairly quicky
# !! cooling zone also reaches quasi-steady at later stage: temperature change very slowing
################################################################################################################
[Mesh]
  file = simple_3d_May_2012.e
[ ]

[Variables]
  active = 'pressure'
  [./pressure]
    order = FIRST
    family = LAGRANGE
    initial_condition = 10e6
    #scaling = 1e9
  [../]

  [./temperature]
   order = FIRST
   family = LAGRANGE
   initial_condition = 200.0
  [../]
[ ]

[AuxVariables]
# active = 'density_water viscosity_water dwdt dwdp v_x'
 active = 'v_x'
 [./density_water]
 order = FIRST
 family = LAGRANGE
initial_condition = 1000
 [../]
  
 [./viscosity_water]
 order = FIRST
 family = LAGRANGE
 initial_condition = 0.0001
 [../]

 [./dwdt]
 order = FIRST
 family = LAGRANGE
 initial_condition = 0.0
 [../]
 
 [./dwdp]
 order = FIRST
 family = LAGRANGE
 initial_condition = 0.0
 [../]

 [./v_x]
  order = CONSTANT
  family = MONOMIAL
 [../]

 [./v_y]
  order = CONSTANT
  family = MONOMIAL
 [../]
[ ]

[Kernels]
# active = 'p_td p_wmfp t_td t_d t_c'
active = ' p_wmfp'

[./p_td]
 type = MassFluxTimeDerivative_PT
 variable = pressure
 density_water = density_water
 dwdp          = dwdp
 [../]

 [./p_wmfp]
 type = WaterMassFluxPressure_PT
 variable = pressure
 [../]
 
 [./t_td]
 type = TemperatureTimeDerivative
 variable = temperature
 density_water = density_water
 dwdt          = dwdt
 [../]

 [./t_d]
 type = TemperatureDiffusion
 variable = temperature 
 [../]
 
 [./t_c]
 type = TemperatureConvection
 variable = temperature
 [../]

[ ]

[AuxKernels]
# active = 'density_water viscosity_water dwdt dwdp vx'
 active = ' vx'
 [./density_water]
 type = CoupledDensityAux_PT
 variable = density_water
 temperature = temperature
 pressure = pressure
 dwdt = dwdt
 dwdp = dwdp
 density_water = 1000
 temp_dependent_density = false
 [../]

 [./viscosity_water]
 type = CoupledWaterViscosityAux
 variable = viscosity_water
 temperature = temperature
 density_water = density_water
 viscosity_water = 0.0001
 temp_dependent_viscosity = false
 [../]

 [./dwdt]
 type = CoupledDdensityDTAux_PT
 variable = dwdt
 temperature = temperature
 pressure = pressure
 [../]
 
 [./dwdp]
 type = CoupledDdensityDPAux_PT
 variable = dwdp
 temperature = temperature
 pressure = pressure
 [../]

 [./vx]
 type = VelocityAux
 variable = v_x
 component = 0
 [../]

[ ]
 
[BCs]
 #active = 'left_p left_t right_p right_t'
 active = 'left_p right_p'
[./left_p]
type = DirichletBC
variable = pressure
boundary = '1'
value = 10e6
[../]	

[./left_t]
type = DirichletBC
variable = temperature
boundary = '1'
value = 100.
[../]

[./right_p]
type = DirichletBC
variable = pressure
boundary = '2'
value = 1e6
[../]

[./right_t]
    type = DirichletBC
    variable = temperature
    boundary = '2'
    value = 200.
[../]

[ ]

[Materials]
 active = 'rock'
 [./rock]
 type = Geothermal
 block = 1 


  pressure        = pressure
#  density_water   = density_water
 # viscosity_water = viscosity_water
 # temperature     = temperature

 gravity           =  0.0
 gx                =  0.0
 gy                =  0.0
 gz                =  1.0
 material_porosity    =  0.5
 permeability         =  1.0e-14
 density_rock         =  2500
 thermal_conductivity =  2.5E-6
 specific_heat_water  =	4186E-6
 specific_heat_rock   =  920E-6
 youngs_modulus       =   1.50e10
 poissons_ratio       =   0.3
 biot_coeff           =   1.0
 thermal_expansion    =   1.0e-6

 t_ref                =   200

 has_crack = false
 has_damage = false
 [../]
[ ]
 
[Executioner]
#active = 'Adaptivity '
 active = 'Quadrature'
# active = ' '
# type = Steady
# type =  Transient
 type =  SolutionTimeAdaptive
# perf_log =  true

# petsc_options =  '-snes_mf_operator -ksp_monitor'
# petsc_options_iname =  '-pc_type -pc_hypre_type -ksp_gmres_restart'
# petsc_options_value =  'hypre boomeramg 100'

# petsc_options_iname =  ' -snes_ls -pc_type -pc_hypre_type -ksp_gmres_restart'
# petsc_options_value =  ' basic  hypre boomeramg 201' 

# l_max_its  =  100
# l_tol =  1.0e-20
# nl_max_its =  12
# nl_rel_tol =  1e-6
# nl_abs_tol = 1e-20

 num_steps = 10 
 dt = 10.0
#dtmax= 864000.0
# dtmin= 1e-2
# end_time = 1000
 
 [./Adaptivity]
 initial_adaptivity = 1
 error_estimator = KellyErrorEstimator
 refine_fraction  = 0.9
 coarsen_fraction = 0.001
 max_h_level = 2
 [../]
 
 [./Quadrature]
  type = Trap
 [../]
 
[ ]
 
[Output]
 file_base = out
 output_initial = true
 interval = 1
 exodus = true
  print_out_info = true
 [ ]
 