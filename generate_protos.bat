protoc --dart_out=grpc:server/lib/features/greeting protos/greeting.proto

protoc --dart_out=grpc:server/lib/features/file protos/file.proto

protoc --dart_out=grpc:server/lib/features/users protos/users.proto


protoc --dart_out=grpc:client/lib/features/greeting protos/greeting.proto

protoc --dart_out=grpc:client/lib/features/file protos/file.proto

protoc --dart_out=grpc:client/lib/features/users protos/users.proto


