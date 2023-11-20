
all: web client server

.PHONY: web client server clean
# build front end
web:
	@cd web && npm install && npm run build-prod
# embed front end

embed:
	@go install github.com/rakyll/statik@latest
	@statik -m -src="./web/dist" -f -dest="./server/embed" -p web -ns web


# build client
client:
	@go mod tidy && go mod download
	@mkdir built 
	@./scripts/build.client.sh

# build server
server: web embed server-releases
	

server-releases: embed
	@go mod tidy && go mod download
	@mkdir releases
	@./scripts/build.server.sh

clean:
	-@ rm -rf ./web/dist
	-@ rm -rf ./web/node_modules
	-@ rm -rf ./releases
	-@ rm -rf ./built