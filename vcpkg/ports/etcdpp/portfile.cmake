include(vcpkg_common_functions)

# set(VCPKG_BUILD_TYPE release)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL git@github.com:SamuelMarks/libetcd-cpp.git
    REF master
    SHA512 5cde86d103586bd95113cf6a1c0700cac5b4e1fb2d6f8af8eebba92e614e3f70a842affb6ed873735e94d4e16d66528161c98a65e5425866a2033ed513f3fb93
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()

file(WRITE ${CURRENT_PACKAGES_DIR}/share/etcdpp/copyright "")

vcpkg_copy_pdbs()
