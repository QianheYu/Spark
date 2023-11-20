
all: web client server

.PHONY: web client server
# build front end
web:
	cd web && npm install && npm run build-prod
# embed front end
	go install github.com/rakyll/statik@latest
	statik -m -src="./web/dist" -f -dest="./server/embed" -p web -ns web


# build client
client:
	go mod tidy && go mod download
	mkdir built 
	./scripts/build.client.sh

# build server
server: web
	go mod tidy && go mod download
	mkdir releases
	./scripts/build.server.sh