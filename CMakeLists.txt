cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_COMPILER )

project(libetcd-cpp VERSION 0.0.1)

set(CMAKE_CXX_STANDARD 17)

configure_file(lib/version.h.in version.h @ONLY)

find_package(gRPC CONFIG REQUIRED)
find_package(protobuf CONFIG REQUIRED)

add_library(etcdpp SHARED generated/rpc.grpc.pb.cc generated/rpc.pb.cc)
target_include_directories(etcdpp PUBLIC generated)
target_link_libraries(etcdpp PRIVATE gRPC)
target_link_libraries(etcdpp PRIVATE protobuf)
