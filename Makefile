PROJECT:=Circle
PROTO_DIR:=${PROJECT}/Proto

init: ## Init project dependencies
	sudo gem install cocoapods
	make pod
	brew install carthage
	make cart
	brew install swift-protobuf
	make proto

lint: ## Lint XCode
	swiftlint autocorrect ${PROJECT}/**/*.swift

cart: ## Install Carthage Dependencies
	carthage update --platform iOS --cache-builds
	echo "Please link dependencies in Build Phases 'Link Binary With Libraries' and Carthage 'Copy Frameworks Script'"

pod: ## Install pods
	pod install

proto: ## Generate Protobufs
	protoc ${PROTO_DIR}/*.proto --swift_out=./ --swiftgrpc_out=Client=true,Server=false,Async=true,Sync=false:.
