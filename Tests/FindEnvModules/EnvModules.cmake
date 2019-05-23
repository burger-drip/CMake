find_package(EnvModules REQUIRED)
message("module purge")
env_module(COMMAND purge RESULT_VARIABLE ret_var)
if(NOT ret_var EQUAL 0)
  message(FATAL_ERROR "module(purge) returned ${ret_var}")
endif()

message("module avail")
env_module_avail(avail_mods)
foreach(mod IN LISTS avail_mods)
  message("  ${mod}")
endforeach()

if(avail_mods)
  list(GET avail_mods 0 mod0)
  message("module load ${mod0}")
  env_module(load ${mod0})

  message("module list")
  env_module_list(loaded_mods)
  foreach(mod IN LISTS loaded_mods)
    message("  ${mod}")
  endforeach()

  list(LENGTH loaded_mods num_loaded_mods)
  message("Number of modules loaded: ${num_loaded_mods}")
  if(NOT num_loaded_mods EQUAL 1)
    message(FATAL_ERROR "Exactly 1 module should be loaded.  Found ${num_loaded_mods}")
  endif()

  list(GET loaded_mods 0 mod0_actual)
  if(NOT (mod0_actual MATCHES "^${mod0}"))
    message(FATAL_ERROR "Loaded module does not match ${mod0}.  Actual: ${mod0_actual}")
  endif()
endif()