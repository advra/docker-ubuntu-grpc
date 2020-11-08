# Docker Ubuntu gRPC
- [Github Repo](https://github.com/advra/docker-ubuntu-grpc)
- [Docker Hub](https://hub.docker.com/repository/docker/asdfadrian/ubuntu-grpc)

Size: 2.24GB / 1.78 GB  (Uncompressed / Compressed)

Based off the `Ubuntu:Latest` Image with gRPC and protobufs installed located in `/grpc`.

## Grab the container
`docker pull asdfadrian/ubuntu-grpc:latest`

## To Use
Go your project files in the root and run `docker run --rm -it --name grpc-project -v $PWD:/projectfiles asdfadrian/ubuntu-grpc` to run the container and auto mount your project. `--rm` is used to persist your project changes. Alternatively you can run the `mount_container.sh` for convenience.

## Extend from this container:
Create your own Dockerfile and use `FROM asdfadrian/ubuntu-grpc:latest` as the base.

## Issues ?
Having issues you'd like to report? Open an Issue on the [Github Repo](https://github.com/advra/docker-ubuntu-grpc).

## VsCode Config
If using vscode, be sure to include both the grpc and protobuf as shown below in the projects `c_cpp_properties.json` file.
```
{
    "configurations": [
        {
            "name": "Linux",
            "includePath": [
                "${default}",     
                "${workspaceFolder}",                 
                "/grpc/include",                       // include this for grpc headers
                "/grpc/third_party/protobuf/src/"      // include this protobuf headers
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
