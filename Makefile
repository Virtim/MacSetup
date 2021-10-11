# Creaate month and year variable
MMWWYY=$(shell date +%m%U%Y)

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
	git checkout -b TM-update-$(MMWWYY)
	brew bundle dump -f
	git add .
	git commit -m "Weekly update $(MMWWYY)"
	git push -u origin TM-update-$(MMWWYY)