# Creaate month and year variable
MMYY=$(shell date +%m%Y)

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
	git checkout -B master origin/master
	git checkout -b TM-update-$(MMYY)
	brew bundle dump -f
	git add .
	git commit -m "Monthly update $(MMYY)"
	git push -u origin TM-update-$(MMYY)