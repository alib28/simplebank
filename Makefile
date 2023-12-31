postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=admin123 postgres:14-alpine

createdb:
	docker exec -it postgres14 createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres14 dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgres://postgres:admin123@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgres://postgres:admin123@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test