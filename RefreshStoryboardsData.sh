#!/bin/bash
#SRCROOT="${SRCROOT}"

#some = $(<"FilmFest/UpdateConstants.swift")


swift_code() {
cat "${PODS_ROOT}/StoryboardIdentification/StoryboardIdentification/StoryboardIdentifiers.swift";

cat<<EOF
StoryboardIdentifiers.updateStoryboarIDs(srcRoot: "${SRCROOT}")
EOF
}

echo "$(swift_code)" | DEVELOPER_DIR="$DEVELOPER_DIR" xcrun --sdk macosx "$TOOLCHAIN_DIR/usr/bin/"swift > "output.log"
