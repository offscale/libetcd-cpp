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
set -e

CMD=(
    protoc
    -I "$REPO_ROOT"/..
    -I "$REPO_ROOT"/gopath.proto/src/github.com/gogo/protobuf
    -I "$REPO_ROOT"/gopath.proto/src/github.com/gogo/protobuf/protobuf
    -I "$REPO_ROOT"/etcdserver/etcdserverpb
    -I "$REPO_ROOT"/gopath.proto/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis
    -I "$REPO_ROOT"/mvcc/mvccpb
    -I "$REPO_ROOT"/auth/authpb
)
grpc_cpp_plugin=$(which grpc_cpp_plugin)
PBHH_CMD=("${CMD[@]}" --cpp_out=.)
GRPC_CMD=("${CMD[@]}" --grpc_out=. --plugin=protoc-gen-grpc="$grpc_cpp_plugin")

TARGET="$REPO_ROOT"/etcdserver/etcdserverpb/rpc.proto

"${PBHH_CMD[@]}" "$TARGET"
"${GRPC_CMD[@]}" "$TARGET"

"${PBHH_CMD[@]}" "$REPO_ROOT"/gopath.proto/src/github.com/gogo/protobuf/gogoproto/gogo.proto
"${PBHH_CMD[@]}" "$REPO_ROOT"/mvcc/mvccpb/kv.proto
"${PBHH_CMD[@]}" "$REPO_ROOT"/auth/authpb/auth.proto
"${PBHH_CMD[@]}" "$REPO_ROOT"/gopath.proto/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api/annotations.proto
