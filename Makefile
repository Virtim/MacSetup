all:
	sh osx.sh
	sh brew.sh
	sh android.sh
	./.macos
android:
	# will only work with brew installed
	sh android.sh
brew:
	sh brew.sh
git:
	sh git.sh
macos:
	sh osx.sh