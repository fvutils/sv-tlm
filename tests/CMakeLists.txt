
#include(GoogleTest)

find_package(Threads REQUIRED)

include (ExternalProject)

ExternalProject_Add(
  SystemC
  PREFIX systemc
  SOURCE_DIR ${PACKAGES_DIR}/systemc
  CMAKE_CACHE_ARGS
    -DCMAKE_C_COMPILER:STRING=${CMAKE_C_COMPILER}
    -DCMAKE_CXX_COMPILER:STRING=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_BINARY_DIR}
    -DCMAKE_BUILD_TYPE:STRING=Release
  )
  
# ExternalProject_Get_Property(GTEST source_dir binary_dir)

# # find_package(Gtest)

# add_library(libgtest IMPORTED STATIC GLOBAL)
# add_dependencies(libgtest GTEST)

# set_target_properties(libgtest PROPERTIES
#     "IMPORTED_LOCATION" "${binary_dir}/lib/libgtest.a"
#     "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
#     )

# add_library(libgmock IMPORTED STATIC GLOBAL)
# add_dependencies(libgmock gtest)

# set_target_properties(libgmock PROPERTIES
#     "IMPORTED_LOCATION" "${binary_dir}/lib/libgmock.a"
#     "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
#     )
    
# include_directories(
# 	"${source_dir}/googletest/include"
# 	"${source_dir}/googlemock/include"
#     ${JSON_DIR}/include
#     "${vsc_dm_INCDIR}"
#     "${debug_mgr_INCDIR}"
# 	)

# file(GLOB test_zuspec_arl_dm_SRC
#   "src/*.h"
#   "src/*.cpp"
#   )

# add_executable(test-zuspec-arl-dm ${test_zuspec_arl_dm_SRC})
# target_include_directories(test-zuspec-arl-dm PUBLIC
#     "${source_dir}/googletest/include"
#     "${CMAKE_SOURCE_DIR}/src/include"
#     ${LIBVSC_DM_DIR}/src/include
#     ${LIBVSC_DM_DIR}/src
#     "${vsc_dm_INCDIR}"
#     "${debug_mgr_INCDIR}"
#     )
   
# target_link_directories(test-zuspec-arl-dm PRIVATE
#     ${CMAKE_BINARY_DIR}/lib
#     ${CMAKE_BINARY_DIR}/lib64
#     ${CMAKE_BINARY_DIR}/glog/lib64
#     "${vsc_dm_LIBDIR}"
#     "${debug_mgr_LIBDIR}"
#     )
  
# if (CMAKE_BUILD_TYPE STREQUAL "Debug")
# 	set(libglog glogd)
# else()
# 	set(libglog glog)
# endif()

# target_link_libraries(test-zuspec-arl-dm 
# 	zsp-arl-dm
#     vsc-dm
# 	libgtest 
# 	libgmock
# 	)
# add_dependencies(test-zuspec-arl-dm GTEST)
# #set_property(TARGET test_libvsc PROPERTY INTERPROCEDURAL_OPTIMIZATION OFF)

# gtest_discover_tests(test-zuspec-arl-dm)
