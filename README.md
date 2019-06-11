libetcd-cpp
=================
[gRPC](https://grpc.io) C++ client for [etcd](http://etcd.io/).

gRPC and protobuf files were copied from etcd source code and a bit simplified. Current protocol version is 3.3. CMake will automatically generate C++ sources and compile them for you.

## Dependencies

- grpc
- protobuf

## Developer workflow

```sh
mkdir cmake-build-debug && cd $_
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE='<replace with path to vcpkg.cmake>" ..
cmake --build .
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or <https://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <https://opensource.org/licenses/MIT>)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.