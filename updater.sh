#!/usr/bin/env sh

set -e

update () {

	relnum=$(awk '/tar.*/{print NR; exit}' "$MANIFEST_PATH")
	vernum=$(awk '/VERSION:/{print NR; exit}' "$MANIFEST_PATH")
	shanum=$(awk '/sha256/{print NR}' "$MANIFEST_PATH"|tail -n 1)
	oldrelease=$(sed "${relnum}!d" "$MANIFEST_PATH"|sed -n '{s|.*/thunderbird-\(.*\)\.tar.*|\1|p;q;}')
	newrelease=$(curl -I -s -L "https://download.mozilla.org/?product=thunderbird-nightly-latest-SSL&os=linux64&lang=en-US" 2>&1 | sed -n '/Location: /{s|.*/thunderbird-\(.*\)\.tar.*|\1|p;q;}')
	sed -i "${relnum}s/$oldrelease/$newrelease/g" "$MANIFEST_PATH"
	updrelease=$(sed "${relnum}!d" "$MANIFEST_PATH"|sed -n '{s|.*/thunderbird-\(.*\)\.tar.*|\1|p;q;}')
	versionold=$(echo "$oldrelease"|head -c 7)
	versionnew=$(echo "$updrelease"|head -c 7)
	sed -i "${vernum}s/VERSION: $versionold/VERSION: $versionnew/g" "$MANIFEST_PATH"
	curl -s -O https://download-installer.cdn.mozilla.net/pub/thunderbird/nightly/latest-comm-central/thunderbird-"$updrelease".checksums
	shanew=$(grep "$updrelease".tar.xz < thunderbird-"$updrelease".checksums|grep -v asc|grep -v sha512|cut -d " " -f1)
	shaold=$(sed "${shanum}!d" "$MANIFEST_PATH"|cut -d: -f2|sed 's/^[ \t]*//;s/[ \t]*$//')
	sed -i "${shanum}s/$shaold/$shanew/g" "$MANIFEST_PATH"
	rm -- *.checksums

}

if [ -z "$CI_PROJECT_DIR" ]; then
	export APP_ID=org.mozilla.ThunderbirdNightly
	export MANIFEST_PATH="$PWD"/"$APP_ID".yaml
else
	export MANIFEST_PATH="$CI_PROJECT_DIR"/"$APP_ID".yaml
fi

if [ ! -f "$MANIFEST_PATH" ]; then
	echo "Manifest not found in current working directory"
	exit 1
else
	update
fi
