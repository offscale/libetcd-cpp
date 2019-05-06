cmake_minimum_required(VERSION 3.5)

project(libetcd-cpp VERSION 0.0.1)

set(CMAKE_CXX_STANDARD 17)

configure_file(lib/version.h.in version.h @ONLY)

find_package(gRPC REQUIRED)
find_package(protobuf REQUIRED)

file(GLOB_RECURSE protos LIST_DIRECTORIES false "proto/*.proto")
file(GLOB main_proto LIST_DIRECTORIES false "proto/rpc.proto")

file(MAKE_DIRECTORY generated)
file(GLOB generated_path LIST_DIRECTORIES true "generated")
file(GLOB protodir_path LIST_DIRECTORIES true "proto")

set(rpc_protofiles "${generated_path}/rpc.grpc.pb.cc;${generated_path}/rpc.grpc.pb.h")
set(common_protofiles "")
set(exts .pb.cc .pb.h)

foreach(_proto ${protos})
	get_filename_component(_basename ${_proto} NAME_WE)
    set(_generated_srcs)
    foreach(_ext ${exts})
      list(APPEND common_protofiles "${generated_path}/${_basename}${_ext}")
    endforeach()
endforeach()

add_custom_command(
  OUTPUT  ${rpc_protofiles}
  COMMAND  protobuf::protoc
  ARGS --grpc_out=${generated_path} -I ${protodir_path} --plugin=protoc-gen-grpc=$<TARGET_FILE:gRPC::grpc_cpp_plugin> ${main_proto}
  DEPENDS  gRPC::grpc_cpp_plugin protobuf::protoc ${main_proto}
  COMMENT   "Running grpc protocol buffer compiler on ${main_proto}"
  VERBATIM )

add_custom_command(
  OUTPUT ${common_protofiles}
  COMMAND  protobuf::protoc
  ARGS --cpp_out=${generated_path} -I ${protodir_path} ${protos}
  DEPENDS ${protos} protobuf::protoc
  COMMENT "Running cpp protocol buffer compiler on ${protos}"
  VERBATIM )

set(protofiles "${common_protofiles};${rpc_protofiles}")
set(proto_ccs)
set(proto_hs)
foreach(_file ${protofiles})
if(_file MATCHES "cc$")
  list(APPEND proto_ccs ${_file})
else()
  list(APPEND proto_hs ${_file})
endif()
endforeach()

message(STATUS "Proto files: ${protofiles}")
message(STATUS "Proto ccs: ${proto_ccs}")
message(STATUS "Proto hs: ${proto_hs}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

add_library(etcdpp SHARED ${proto_ccs})

target_include_directories(etcdpp PRIVATE "generated/")
target_include_directories(etcdpp INTERFACE "${CMAKE_INSTALL_PREFIX}/include")

target_link_libraries(etcdpp PRIVATE gRPC::gpr gRPC::grpc gRPC::grpc++ gRPC::grpc_cronet)
target_link_libraries(etcdpp PRIVATE protobuf::libprotoc protobuf::libprotobuf)

install(TARGETS etcdpp EXPORT etcdpp DESTINATION lib)

if (${CMAKE_BUILD_TYPE} STREQUAL "Release")
	install(FILES ${proto_hs} DESTINATION include/etcdpp/)
	install(EXPORT etcdpp DESTINATION share/etcdpp/ FILE etcdppConfig.cmake)
endif()
