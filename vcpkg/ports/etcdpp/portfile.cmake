include(vcpkg_common_functions)

# set(VCPKG_BUILD_TYPE release)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL git@github.com:SamuelMarks/libetcd-cpp.git
    REF master
    SHA512 36bb77dbd903db3d5f122d921feb2ed946f96fbc81e8e93716f7567a59fb6ce8b15d2349158d1923be65c42b974c29eddc61592d65c516dac041195babac8abb
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/etcdpp/copyright "")

vcpkg_copy_pdbs()
