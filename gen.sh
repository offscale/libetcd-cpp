#!/usr/bin/env bash

usage() {
    echo >&2 "USAGE: $0 <root of the etcd repository>

NOTE: before running this script, run 'scripts/genproto.sh' from the root of etcd repository."
    exit 2
}

if (( $# != 1 )); then
    usage
fi

REPO_ROOT=$1

CMD=(
    protoc
    -I "$REPO_ROOT"/..
    -I "$REPO_ROOT"/gopath.proto/src/github.com/gogo/protobuf
    -I "$REPO_ROOT"/gopath.proto/src/github.com/gogo/protobuf/protobuf
    -I "$REPO_ROOT"/etcdserver/etcdserverpb
    -I "$REPO_ROOT"/gopath.proto/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis
    "$REPO_ROOT"/etcdserver/etcdserverpb/rpc.proto
)

set -e

grpc_cpp_plugin=$(which grpc_cpp_plugin)
"${CMD[@]}" --grpc_out=. --plugin=protoc-gen-grpc="$grpc_cpp_plugin"
"${CMD[@]}" --cpp_out=.
