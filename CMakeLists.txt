cmake_minimum_required(VERSION 3.5)

project(libetcd-cpp VERSION 0.0.1)

set(CMAKE_CXX_STANDARD 17)

configure_file(lib/version.h.in version.h @ONLY)

set(protobuf_MODULE_COMPATIBLE 1)

find_package(gRPC REQUIRED)
find_package(protobuf REQUIRED)

file(GLOB_RECURSE protos LIST_DIRECTORIES false "proto/*.proto")
protobuf_generate_cpp(proto_ccs proto_hs ${protos})

message(STATUS "Proto ccs: ${proto_ccs}")
message(STATUS "Proto hs: ${proto_hs}")

file(MAKE_DIRECTORY generated_incl)
file(COPY ${proto_hs} DESTINATION generated_incl)

add_library(etcdpp SHARED ${proto_ccs})

target_include_directories(etcdpp PRIVATE "generated_incl/")
target_include_directories(etcdpp INTERFACE "${CMAKE_INSTALL_PREFIX}/include/etcdpp/")

target_include_directories(etcdpp PUBLIC generated_incl)
target_link_libraries(etcdpp PUBLIC gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc_cronet)
target_link_libraries(etcdpp PUBLIC protobuf::libprotoc protobuf::libprotobuf)

install(TARGETS etcdpp EXPORT etcdpp DESTINATION lib)
install(FILES ${proto_hs} DESTINATION include/etcdpp/)
install(EXPORT etcdpp DESTINATION share/etcdpp/ FILE etcdppConfig.cmake)
