#
# setup and static libraries
#

set(RA_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH
	"rathena include directory"
)
mark_as_advanced( RA_INCLUDE_DIRS )

# Add custom directory to include path for defines_pre.hpp and defines_post.hpp
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/custom)



add_subdirectory( common )
if( HAVE_common )
	option( BUILD_SERVERS "build server executables" ON )
else()
	message( STATUS "Disabled server targets (requires common)" )
endif()


#
# targets
#
add_subdirectory( login )
add_subdirectory( char )
add_subdirectory( map )
add_subdirectory( web )
add_subdirectory( tool )

