#!/bin/bash
SCHEME='Molio'
DESTINATION='platform=iOS Simulator,OS=17.0.1,name=iPhone 15 Pro'
xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO'