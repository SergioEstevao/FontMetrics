if [ ! $TRAVIS ]; then
	TRAVIS_XCODE_PROJECT=FontMetrics.xcodeproj
	TRAVIS_XCODE_SCHEME=FontMetrics
        TRAVIS_XCODE_SDK=iphonesimulator
fi

xcodebuild build test \
	-project "$TRAVIS_XCODE_PROJECT" \
	-scheme "$TRAVIS_XCODE_SCHEME" \
	-sdk "$TRAVIS_XCODE_SDK" \
        -destination "platform=iOS Simulator,OS=13.4,name=iPhone 7" \
	-configuration Debug | xcpretty -c && exit ${PIPESTATUS[0]}




	
