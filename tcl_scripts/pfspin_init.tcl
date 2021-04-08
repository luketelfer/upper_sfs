#---------------------------------------------------------
# 0.  QUICK START
# 1.  IMPORT PARFLOW TCL PACKAGE
# 2.  SET PROCESSORS
# 3.  SETUP RUN DIRECTORY
# 4.  COPY INPUT FILES
# 5.  SPECIFY TOPO SLOPES
# 6.  COMPUTATIONAL GRID
# 7.  SUBSURFACE LAYERS
# 8.  SPINUP KEYS
# 9.  TIMING (units: hr)
# 10. TIME CYCLES (units: hr)
# 11. INITIAL CONDITIONS: WATER PRESSURE
# 12. BOUNDARY CONDITIONS: PRESSURE
# 13. GEOMETRY INPUTS
# 14. PERMEABILITY (units: m/hr)
# 15. RELATIVE PERMEABILITY
# 16. POROSITY
# 17. SATURATION
# 18. SPECIFIC STORAGE
# 19. MANNINGS COEFFICIENT
# 20. PHASES AND PHASE SOURCES
# 21. GRAVITY
# 22. DOMAIN
# 23. MOBILITY
# 24. CONTAMINANTS, RETARDATION, WELLS
# 25. EXACT SOLUTION SPECIFICATION FOR ERROR CALCULATIONS
# 26. SET SOLVER PARAMETERS
# 27. SET CLM SOLVER PARAMETERS
# 28. OUTPUT SETTINGS
# 29. DISTRIBUTE, RUN SIMULATION, UNDISTRIBUTE
#---------------------------------------------------------




#---------------------------------------
# 0. QUICK START
#---------------------------------------
set start_count             0
set time_step               1
set start_time              0
set stop_time               150000
set timedump                100
#---------------------------------------
set precip                  0.0000696861
#---------------------------------------
set netcdf_filesize         1000
#---------------------------------------




#---------------------------------------
# 1. IMPORT PARFLOW TCL PACKAGE
#---------------------------------------
set tcl_precision 17
lappend auto_path $env(PARFLOW_DIR)/bin
package require parflow
namespace import Parflow::*
pfset FileVersion 4
#---------------------------------------




#----------------------------------
# 2. SET PROCESSORS
#----------------------------------
pfset Process.Topology.P 1
pfset Process.Topology.Q 2
pfset Process.Topology.R 1
#----------------------------------




#-------------------------------------------------------------------------------------------------
# 3. SETUP RUN DIRECTORY
#-------------------------------------------------------------------------------------------------
puts [pwd]
set basedir [pwd]
set rundir [lindex $argv 0]
set runname [lindex $argv 1]
cd output_files/${rundir}
file mkdir $runname 
cd $runname
#-------------------------------------------------------------------------------------------------
file copy -force ${basedir}/input_files/domain_inputs/usfs_slopex.pfb .
file copy -force ${basedir}/input_files/domain_inputs/usfs_slopey.pfb .
file copy -force ${basedir}/input_files/domain_inputs/usfs.pfsol .
file copy -force ${basedir}/input_files/domain_inputs/usfs_indicator.pfb ${runname}_indicator.pfb
#-------------------------------------------------------------------------------------------------
puts "Files Copied"
#-------------------------------------------------------------------------------------------------




#--------------------------------------------
# 5. SPECIFY TOPO SLOPES
#--------------------------------------------
pfset TopoSlopesX.Type        "PFBFile"
pfset TopoSlopesY.Type        "PFBFile"
#--------------------------------------------
pfset TopoSlopesX.GeomNames   "domain"
pfset TopoSlopesY.GeomNames   "domain"
#--------------------------------------------
pfset TopoSlopesX.FileName    usfs_slopex.pfb
pfset TopoSlopesY.FileName    usfs_slopey.pfb
#--------------------------------------------




#----------------------------------------
# 6. COMPUTATIONAL GRID
#----------------------------------------
pfset ComputationalGrid.Lower.X   0.0
pfset ComputationalGrid.Lower.Y   0.0
pfset ComputationalGrid.Lower.Z   0.0
#----------------------------------------
pfset ComputationalGrid.NX        24
pfset ComputationalGrid.NY        64
pfset ComputationalGrid.NZ        25
#----------------------------------------
pfset ComputationalGrid.DX        1000.0
pfset ComputationalGrid.DY        1000.0
pfset ComputationalGrid.DZ        40.0
#----------------------------------------




#------------------------------------------
# 7. SUBSURFACE LAYERS
#------------------------------------------
pfset Solver.Nonlinear.VariableDz   True
#------------------------------------------
pfset dzScale.GeomNames             domain
pfset dzScale.Type                  nzList
pfset dzScale.nzListNumber          25
#------------------------------------------
pfset Cell.0.dzScale.Value         6.2500
pfset Cell.1.dzScale.Value         6.2500
pfset Cell.2.dzScale.Value         6.2500
pfset Cell.3.dzScale.Value         3.7500
pfset Cell.4.dzScale.Value         2.0000
pfset Cell.5.dzScale.Value         0.1500
pfset Cell.6.dzScale.Value         0.0500
pfset Cell.7.dzScale.Value         0.0500
pfset Cell.8.dzScale.Value         0.0500
pfset Cell.9.dzScale.Value         0.0500
pfset Cell.10.dzScale.Value        0.0250
pfset Cell.11.dzScale.Value        0.0250
pfset Cell.12.dzScale.Value        0.0250
pfset Cell.13.dzScale.Value        0.0250
pfset Cell.14.dzScale.Value        0.0250
pfset Cell.15.dzScale.Value        0.0050
pfset Cell.16.dzScale.Value        0.0050
pfset Cell.17.dzScale.Value        0.0040
pfset Cell.18.dzScale.Value        0.0040
pfset Cell.19.dzScale.Value        0.0020
pfset Cell.20.dzScale.Value        0.0020
pfset Cell.21.dzScale.Value        0.0010
pfset Cell.22.dzScale.Value        0.0010
pfset Cell.23.dzScale.Value        0.0005
pfset Cell.24.dzScale.Value        0.0005
#------------------------------------------




#-------------------------------------
# 8. SPINUP KEYS
#-------------------------------------
#pfset OverlandFlowSpinUp        1
#pfset OverlandSpinupDampP1      10.0
#pfset OverlandSpinupDampP2      0.1
#-------------------------------------




#---------------------------------------------
# 9. TIMING (units: hr)
#---------------------------------------------
pfset TimingInfo.StartCount      $start_count
#---------------------------------------------
pfset TimingInfo.BaseUnit        1.0
#---------------------------------------------
pfset TimeStep.Type              Constant
pfset TimeStep.Value             $time_step
#---------------------------------------------
pfset TimingInfo.StartTime       $start_time
pfset TimingInfo.StopTime        $stop_time
#---------------------------------------------
pfset TimingInfo.DumpInterval    $timedump
#---------------------------------------------




#----------------------------------------------------------
# 10. TIME CYCLES (units: hr)
#----------------------------------------------------------
pfset Cycle.Names                       "constant"
#----------------------------------------------------------
pfset Cycle.constant.Names              "alltime"
pfset Cycle.constant.alltime.Length     1
pfset Cycle.constant.Repeat             -1
#----------------------------------------------------------




#------------------------------------------------------------
# 11. INITIAL CONDITIONS: WATER PRESSURE
#------------------------------------------------------------
pfset ICPressure.Type                       HydroStaticPatch
pfset ICPressure.GeomNames                  domain
#------------------------------------------------------------
pfset Geom.domain.ICPressure.RefGeom        domain
pfset Geom.domain.ICPressure.Value          -20
pfset Geom.domain.ICPressure.RefPatch       top
#------------------------------------------------------------




#----------------------------------------------------------------------------
# 12. BOUNDARY CONDITIONS: PRESSURE
#----------------------------------------------------------------------------
pfset Solver.EvapTransFile                      False
#----------------------------------------------------------------------------
pfset BCPressure.PatchNames                     "land top bottom"
#----------------------------------------------------------------------------
pfset Patch.land.BCPressure.Type                FluxConst
pfset Patch.land.BCPressure.Cycle               "constant"
pfset Patch.land.BCPressure.alltime.Value       0.0
#----------------------------------------------------------------------------
pfset Patch.top.BCPressure.Type                 OverlandFlow
pfset Patch.top.BCPressure.Cycle                "constant"
pfset Patch.top.BCPressure.alltime.Value        -${precip}
#----------------------------------------------------------------------------
pfset Patch.bottom.BCPressure.Type              FluxConst
pfset Patch.bottom.BCPressure.Cycle             "constant"
pfset Patch.bottom.BCPressure.alltime.Value     0.0
#----------------------------------------------------------------------------




#-----------------------------------------------------------------------------------------
# 13. GEOMETRY INPUTS
#-----------------------------------------------------------------------------------------
pfset GeomInput.Names                      "domaininput indicatorinput"
#-----------------------------------------------------------------------------------------
pfset GeomInput.domaininput.GeomName       domain
pfset GeomInput.domaininput.GeomNames      domain
pfset GeomInput.domaininput.InputType      SolidFile
pfset GeomInput.domaininput.FileName       usfs.pfsol
pfset Geom.domain.Patches                  "land top bottom"
#-----------------------------------------------------------------------------------------
pfset GeomInput.indicatorinput.GeomNames   "sandyloam low moderate high saprolite granite"
pfset GeomInput.indicatorinput.InputType   IndicatorField
pfset Geom.indicatorinput.FileName         ${runname}_indicator.pfb
#-----------------------------------------------------------------------------------------
pfset GeomInput.sandyloam.Value            1
pfset GeomInput.low.Value                  2
pfset GeomInput.moderate.Value             3
pfset GeomInput.high.Value                 4
pfset GeomInput.saprolite.Value            5
pfset GeomInput.granite.Value              6
#-----------------------------------------------------------------------------------------




#---------------------------------------------------------------------------------------------
# 14. PERMEABILITY (units: m/hr)
#---------------------------------------------------------------------------------------------
pfset Geom.Perm.Names                   "domain sandyloam low moderate high saprolite granite"
#---------------------------------------------------------------------------------------------
pfset Geom.domain.Perm.Type             Constant
pfset Geom.sandyloam.Perm.Type          Constant
pfset Geom.low.Perm.Type                Constant
pfset Geom.moderate.Perm.Type           Constant
pfset Geom.high.Perm.Type               Constant
pfset Geom.saprolite.Perm.Type          Constant
pfset Geom.granite.Perm.Type            Constant
#---------------------------------------------------------------------------------------------
pfset Geom.domain.Perm.Value            0.0158
pfset Geom.sandyloam.Perm.Value         0.0158
pfset Geom.low.Perm.Value               0.0158
pfset Geom.moderate.Perm.Value          0.0134
pfset Geom.high.Perm.Value              0.0011
pfset Geom.saprolite.Perm.Value         0.0072
pfset Geom.granite.Perm.Value           0.0000000036
#---------------------------------------------------------------------------------------------
pfset Perm.TensorType                   TensorByGeom
pfset Geom.Perm.TensorByGeom.Names      "domain"
pfset Geom.domain.Perm.TensorValX       1.0d0
pfset Geom.domain.Perm.TensorValY       1.0d0
pfset Geom.domain.Perm.TensorValZ       1.0d0
#---------------------------------------------------------------------------------------------




#-------------------------------------------------------------------------------------------------------
# 15. RELATIVE PERMEABILITY
#-------------------------------------------------------------------------------------------------------
pfset Phase.RelPerm.Type                          VanGenuchten
pfset Phase.RelPerm.GeomNames                     "domain sandyloam low moderate high saprolite granite"
#-------------------------------------------------------------------------------------------------------
pfset Geom.domain.RelPerm.Alpha                   2.69
pfset Geom.sandyloam.RelPerm.Alpha                2.69
pfset Geom.low.RelPerm.Alpha                      2.69
pfset Geom.moderate.RelPerm.Alpha                 2.69
pfset Geom.high.RelPerm.Alpha                     2.69
pfset Geom.saprolite.RelPerm.Alpha                1.00
pfset Geom.granite.RelPerm.Alpha                  1.00
#------------------------------------------------------------------------------------------------------- 
pfset Geom.domain.RelPerm.N                       2.45
pfset Geom.sandyloam.RelPerm.N                    2.45
pfset Geom.low.RelPerm.N                          2.45
pfset Geom.moderate.RelPerm.N                     2.45
pfset Geom.high.RelPerm.N                         2.45
pfset Geom.saprolite.RelPerm.N                    3.00
pfset Geom.granite.RelPerm.N                      3.00
#-------------------------------------------------------------------------------------------------------
pfset Geom.domain.RelPerm.NumSamplePoints         20000
pfset Geom.sandyloam.RelPerm.NumSamplePoints      20000
pfset Geom.low.RelPerm.NumSamplePoints            20000
pfset Geom.moderate.RelPerm.NumSamplePoints       20000
pfset Geom.high.RelPerm.NumSamplePoints           20000
pfset Geom.saprolite.RelPerm.NumSamplePoints      20000
pfset Geom.granite.RelPerm.NumSamplePoints        20000
#-------------------------------------------------------------------------------------------------------
pfset Geom.domain.RelPerm.MinPressureHead         -300
pfset Geom.sandyloam.RelPerm.MinPressureHead      -300
pfset Geom.low.RelPerm.MinPressureHead            -300
pfset Geom.moderate.RelPerm.MinPressureHead       -300
pfset Geom.high.RelPerm.MinPressureHead           -300
pfset Geom.saprolite.RelPerm.MinPressureHead      -300
pfset Geom.granite.RelPerm.MinPressureHead        -300
#-------------------------------------------------------------------------------------------------------
pfset Geom.domain.RelPerm.InterpolationMethod     Linear
pfset Geom.sandyloam.RelPerm.InterpolationMethod  Linear
pfset Geom.low.RelPerm.InterpolationMethod        Linear
pfset Geom.moderate.RelPerm.InterpolationMethod   Linear
pfset Geom.high.RelPerm.InterpolationMethod       Linear
pfset Geom.saprolite.RelPerm.InterpolationMethod  Linear
pfset Geom.granite.RelPerm.InterpolationMethod    Linear
#-------------------------------------------------------------------------------------------------------




#----------------------------------------------------------------------------------------------
# 16. POROSITY
#----------------------------------------------------------------------------------------------
pfset Geom.Porosity.GeomNames            "domain sandyloam low moderate high saprolite granite"
#----------------------------------------------------------------------------------------------
pfset Geom.domain.Porosity.Type          Constant
pfset Geom.sandyloam.Porosity.Type       Constant
pfset Geom.low.Porosity.Type             Constant
pfset Geom.moderate.Porosity.Type        Constant
pfset Geom.high.Porosity.Type            Constant
pfset Geom.saprolite.Porosity.Type       Constant
pfset Geom.granite.Porosity.Type         Constant
#----------------------------------------------------------------------------------------------
pfset Geom.domain.Porosity.Value         0.39
pfset Geom.sandyloam.Porosity.Value      0.39
pfset Geom.low.Porosity.Value            0.39
pfset Geom.moderate.Porosity.Value       0.39
pfset Geom.high.Porosity.Value           0.39
pfset Geom.saprolite.Porosity.Value      0.10           
pfset Geom.granite.Porosity.Value        0.01
#----------------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------------------
# 17. SATURATION
#------------------------------------------------------------------------------------------------
pfset Phase.Saturation.Type                VanGenuchten
pfset Phase.Saturation.GeomNames           "domain sandyloam low moderate high saprolite granite"
#------------------------------------------------------------------------------------------------
pfset Geom.domain.Saturation.Alpha         2.69
pfset Geom.sandyloam.Saturation.Alpha      2.69
pfset Geom.low.Saturation.Alpha            2.69
pfset Geom.moderate.Saturation.Alpha       2.69
pfset Geom.high.Saturation.Alpha           2.69
pfset Geom.saprolite.Saturation.Alpha      1.00
pfset Geom.granite.Saturation.Alpha        1.00
#------------------------------------------------------------------------------------------------
pfset Geom.domain.Saturation.N             2.45
pfset Geom.sandyloam.Saturation.N          2.45
pfset Geom.low.Saturation.N                2.45
pfset Geom.moderate.Saturation.N           2.45
pfset Geom.high.Saturation.N               2.45
pfset Geom.saprolite.Saturation.N          3.00
pfset Geom.granite.Saturation.N            3.00
#------------------------------------------------------------------------------------------------
pfset Geom.domain.Saturation.SRes          0.100
pfset Geom.sandyloam.Saturation.SRes       0.100
pfset Geom.low.Saturation.SRes             0.100
pfset Geom.moderate.Saturation.SRes        0.100
pfset Geom.high.Saturation.SRes            0.100
pfset Geom.saprolite.Saturation.SRes       0.001
pfset Geom.granite.Saturation.SRes         0.001
#------------------------------------------------------------------------------------------------
pfset Geom.domain.Saturation.SSat          1.0
pfset Geom.sandyloam.Saturation.SSat       1.0
pfset Geom.low.Saturation.SSat             1.0
pfset Geom.moderate.Saturation.SSat        1.0
pfset Geom.high.Saturation.SSat            1.0
pfset Geom.saprolite.Saturation.SSat       1.0
pfset Geom.granite.Saturation.SSat         1.0
#------------------------------------------------------------------------------------------------




#--------------------------------------------------
# 18. SPECIFIC STORAGE
#--------------------------------------------------
pfset SpecificStorage.GeomNames           "domain"
pfset SpecificStorage.Type                Constant
pfset Geom.domain.SpecificStorage.Value   1.0e-4
#--------------------------------------------------




#-----------------------------------------------
# 19. MANNINGS COEFFICIENT
#-----------------------------------------------
pfset Mannings.GeomNames             "domain"
pfset Mannings.Type                  "Constant"
pfset Mannings.Geom.domain.Value     0.0000044
#-----------------------------------------------




#----------------------------------------------------------
# 20. PHASES AND PHASE SOURCES
#----------------------------------------------------------
pfset Phase.Names                                 "water"
#----------------------------------------------------------
pfset Phase.water.Density.Type	                  Constant
pfset Phase.water.Density.Value	                  1.0
#----------------------------------------------------------
pfset Phase.water.Viscosity.Type                  Constant
pfset Phase.water.Viscosity.Value                 1.0
#----------------------------------------------------------
pfset PhaseSources.water.Type                     Constant
pfset PhaseSources.water.GeomNames                domain
pfset PhaseSources.water.Geom.domain.Value        0.0
#----------------------------------------------------------




#-------------------------------
# 21. GRAVITY
#-------------------------------
pfset Gravity               1.0
#-------------------------------




#--------------------------------
# 22. DOMAIN
#--------------------------------
pfset Domain.GeomName     domain
#--------------------------------




#-----------------------------------------------
# 23. MOBILITY
#-----------------------------------------------
pfset Phase.water.Mobility.Type        Constant
pfset Phase.water.Mobility.Value       1.0
#-----------------------------------------------




#--------------------------------------------
# 24. CONTAMINANTS, RETARDATION, WELLS
#--------------------------------------------
pfset Contaminants.Names                  ""
#--------------------------------------------
pfset Geom.Retardation.GeomNames          ""
#--------------------------------------------
pfset Wells.Names                         ""
#--------------------------------------------




#---------------------------------------------------------
# 25. EXACT SOLUTION SPECIFICATION FOR ERROR CALCULATIONS
#---------------------------------------------------------
pfset KnownSolution               NoKnownSolution
#---------------------------------------------------------




#---------------------------------------------------------------------
# 26. SET SOLVER PARAMETERS
#---------------------------------------------------------------------
pfset Solver                                             Richards
pfset Solver.TerrainFollowingGrid                        True
pfset Solver.Nonlinear.UseJacobian                       True
pfset Solver.Nonlinear.EtaChoice                         EtaConstant
pfset Solver.Linear.Preconditioner                       PFMG
pfset Solver.Linear.Preconditioner.PCMatrixType          FullJacobian
#---------------------------------------------------------------------
pfset Solver.MaxIter                                     1000000
pfset Solver.MaxConvergenceFailures                      5
pfset Solver.Linear.KrylovDimension                      500
pfset Solver.Linear.MaxRestarts                          20
pfset Solver.Nonlinear.MaxIter                           200
pfset Solver.Nonlinear.ResidualTol                       1e-5
pfset Solver.Nonlinear.EtaValue                          1e-3
pfset Solver.Nonlinear.DerivativeEpsilon                 1e-16
pfset Solver.Nonlinear.StepTol                           1e-25
#---------------------------------------------------------------------




#----------------------------------------------------------------------
# 28. OUTPUT SETTINGS
#----------------------------------------------------------------------
pfset NetCDF.NumStepsPerFile                          $netcdf_filesize
pfset NetCDF.WritePressure                            True
pfset NetCDF.WriteSaturation                          True
pfset NetCDF.WriteMannings                            True
pfset NetCDF.WriteSubsurface                          True
pfset NetCDF.WriteSlopes                              True
pfset NetCDF.WriteMask                                True
pfset NetCDF.WriteDZMultiplier                        True
pfset NetCDF.WriteEvapTrans                           True
pfset NetCDF.WriteEvapTransSum                        True
pfset NetCDF.WriteOverlandSum                         True
pfset Solver.PrintPressure                            True
#----------------------------------------------------------------------
pfset NetCDF.WriteOverlandBCFlux                      False
pfset Solver.PrintDZMultiplier                        False
pfset Solver.PrintMannings                            False
pfset Solver.PrintMask                                False
pfset Solver.PrintOverlandSum                         False
pfset Solver.PrintSaturation                          False
pfset Solver.PrintSlopes                              False
pfset Solver.PrintSpecificStorage                     False
pfset Solver.PrintSubsurfData                         False
pfset Solver.PrintConcentration                       False
pfset Solver.PrintLSMSink                             False
pfset Solver.PrintTop                                 False
pfset Solver.PrintVelocities                          False
pfset Solver.PrintWells                               False
pfset Solver.PrintOverlandBCFlux                      False
pfset Solver.PrintEvapTrans                           False
pfset Solver.PrintEvapTransSum                        False
pfset Solver.WriteSiloSpecificStorage                 False
pfset Solver.WriteSiloMannings                        False
pfset Solver.WriteSiloMask                            False
pfset Solver.WriteSiloSlopes                          False
pfset Solver.WriteSiloSubsurfData                     False
pfset Solver.WriteSiloPressure                        False
pfset Solver.WriteSiloSaturation                      False
pfset Solver.WriteSiloEvapTrans                       False
pfset Solver.WriteSiloEvapTransSum                    False
pfset Solver.WriteSiloOverlandSum                     False
pfset Solver.WriteSiloCLM                             False
pfset Solver.WriteSiloConcentration                   False
pfset Solver.WriteSiloVelocities                      False
pfset Solver.WriteSiloSpecificStorage                 False
#----------------------------------------------------------------------




#----------------------------------------------
# 29. DISTRIBUTE, RUN SIMULATION, UNDISTRIBUTE
#----------------------------------------------
pfdist -nz 1 usfs_slopex.pfb
pfdist -nz 1 usfs_slopey.pfb
pfdist ${runname}_indicator.pfb
#----------------------------------------------
puts    $runname
pfrun   $runname
#----------------------------------------------
pfundist $runname
pfundist usfs_slopex.pfb
pfundist usfs_slopey.pfb
pfundist ${runname}_indicator.pfb
#----------------------------------------------
puts "ParFlow run complete"
#----------------------------------------------




#---------------------------------------------------------
# 0.  QUICK START
# 1.  IMPORT PARFLOW TCL PACKAGE
# 2.  SET PROCESSORS
# 3.  SETUP RUN DIRECTORY
# 4.  COPY INPUT FILES
# 5.  SPECIFY TOPO SLOPES
# 6.  COMPUTATIONAL GRID
# 7.  SUBSURFACE LAYERS
# 8.  SPINUP KEYS
# 9.  TIMING (units: hr)
# 10. TIME CYCLES (units: hr)
# 11. INITIAL CONDITIONS: WATER PRESSURE
# 12. BOUNDARY CONDITIONS: PRESSURE
# 13. GEOMETRY INPUTS
# 14. PERMEABILITY (units: m/hr)
# 15. RELATIVE PERMEABILITY
# 16. POROSITY
# 17. SATURATION
# 18. SPECIFIC STORAGE
# 19. MANNINGS COEFFICIENT
# 20. PHASES AND PHASE SOURCES
# 21. GRAVITY
# 22. DOMAIN
# 23. MOBILITY
# 24. CONTAMINANTS, RETARDATION, WELLS
# 25. EXACT SOLUTION SPECIFICATION FOR ERROR CALCULATIONS
# 26. SET SOLVER PARAMETERS
# 27. SET CLM SOLVER PARAMETERS
# 28. OUTPUT SETTINGS
# 29. DISTRIBUTE, RUN SIMULATION, UNDISTRIBUTE
#---------------------------------------------------------















