all:
	sh osx.sh
	sh brew.sh
	sh android.sh
	./.macos
macos:
	sh osx.sh
android:
	# will only work with brew installed
	sh android.sh
brew:
	sh brew.sh