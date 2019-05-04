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

cp "$REPO_ROOT/etcdserver/etcdserverpb/rpc.proto" .
cp "$REPO_ROOT"/mvcc/mvccpb/*.proto .
cp "$REPO_ROOT"/auth/authpb/*.proto .
