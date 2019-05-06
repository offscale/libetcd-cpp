include(vcpkg_common_functions)

# set(VCPKG_BUILD_TYPE release)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL git@github.com:SamuelMarks/libetcd-cpp.git
    REF master
    SHA512 b04f332a9ac8cc88a9d551ba16ff1d526abb686cc1a7ffc51f64d1ba6bf229ad7eb232fd2e6c9d3fdcecc5e23e3a5de69d4ec76a65d300bede4872e2f48622f8
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/etcdpp/copyright "")

vcpkg_copy_pdbs()
