postgres:
	docker run -it -d --name postgres-db-1 -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=root -e TZ=Asia/Shanghai -p 5432:5432 -v ./data:/var/lib/postgresql/data gh.106060.xyz/postgres:17-alpine

createdb:
	docker exec -it postgres-db-1 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres-db-1 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
