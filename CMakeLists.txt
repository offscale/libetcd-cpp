cmake_minimum_required(VERSION 3.5)

project(libetcd-cpp VERSION 0.0.1)

set(CMAKE_CXX_STANDARD 17)

configure_file(lib/version.h.in version.h @ONLY)

find_package(gRPC CONFIG REQUIRED)
find_package(protobuf CONFIG REQUIRED)

file(GLOB_RECURSE ccs LIST_DIRECTORIES false "*.cc")
add_library(etcdpp SHARED ${ccs})
target_include_directories(etcdpp PUBLIC generated)
target_link_libraries(etcdpp PUBLIC gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc_cronet)
target_link_libraries(etcdpp PUBLIC protobuf::libprotoc protobuf::libprotobuf)
