# docker-ubuntu-grpc
Latest Ubuntu Image with grpc natively installed and protobufs.
https://hub.docker.com/repository/docker/asdfadrian/ubuntu-grpc/general

## To Use
Place your project files in the root and run the convenience script `mount_container.sh` to run the container and auto mount your project.

## Extend from this container:
Create your own Dockerfile and use `FROM asdfadrian/ubuntu-grpc:latest` as the base

### Note: If using vscode be set the following `c_cpp_properties.json` config:
```
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${default}",     
                "${workspaceFolder}",                 
                "/grpc/include",                    // grpc headers
                "/protobuf/src/google/protobuf"     // protobuf headers
            ],
            "defines": [],
            "compilerPath": "/usr/bin/gcc",
            "cStandard": "gnu18",
            "cppStandard": "gnu++14",
            "intelliSenseMode": "gcc-x64"
        }
    ],
    "version": 4
}
```
