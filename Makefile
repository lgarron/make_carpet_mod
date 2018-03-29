DOWNLOAD_CARPET = "https://www.dropbox.com/s/yfzuqfgloe3a95s/carpet_mod_for_1.12.0_server_v18_01_29_patch.zip?dl=0"
DOWNLOAD_SERVER = "https://s3.amazonaws.com/Minecraft.Download/versions/1.12/minecraft_server.1.12.jar"

SRC_CARPET = download/carpet_mod_for_1.12.0_server_v18_01_29_patch.zip
SRC_SERVER = download/minecraft_server.1.12.jar
TEMP_CARPET = temp/carpet_mod_for_1.12.0_server_v18_01_29_patch
TEMP_SERVER = temp/minecraft_server.1.12_temp.zip
OUTPUT_SERVER = output/carpet_v18_01_29.jar

.PHONY: default
default: setup $(OUTPUT_SERVER)

.PHONY: setup
setup:
	mkdir -p download
	mkdir -p output
	mkdir -p temp

$(SRC_CARPET):
	curl -L $(DOWNLOAD_CARPET) > $(SRC_CARPET)

$(SRC_SERVER):
	curl -L $(DOWNLOAD_SERVER) > $(SRC_SERVER)

$(OUTPUT_SERVER): $(TEMP_CARPET) $(TEMP_SERVER)
	cd $(TEMP_CARPET) && zip -ur ../../$(TEMP_SERVER) ./
	mv $(TEMP_SERVER) $(OUTPUT_SERVER)

$(TEMP_CARPET)/: $(SRC_CARPET)
	unzip $(SRC_CARPET) -d $@

$(TEMP_SERVER): $(SRC_SERVER)
	cp $(SRC_SERVER) $@

.PHONY: clean
clean:
	rm -rf ./temp/*
	rm -rf ./output/*

.PHONY: clean-downloads
clean-downloads:
	rm -rf ./download/*
