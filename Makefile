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
monthlyupdate:
	MMYY=$(date +%m%Y) &&  \
	echo $MMYY && \
	git checkout -B master origin/master && \
	git checkout -b TM-update-"$MMYY" && \
	brew bundle dump -f && \
	git add . && \
	git commit -m "Monthly update $MMYY" && \
	git push -u origin TM-update-"$MMYY"