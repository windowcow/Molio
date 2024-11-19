#!/bin/bash
SCHEME='Molio'
DESTINATION='platform=iOS Simulator,OS=18.0,name=iPhone 16 Pro'
xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'