# Creaate month and year variable
MMWWYY=$(shell date +%m%U%Y)

all:
	sh osx.sh
	sh brew.sh
	sh android.sh
	./.macos
	sh dotfiles.sh
android:
	# will only work with brew installed
	sh android.sh
brew:
	sh brew.sh
git:
	sh git.sh
dotfiles:
	sh dotfiles.sh
macos:
	sh osx.sh
monthlyupdate:
	git checkout -B master origin/master
	git checkout -b TM-update-$(MMWWYY)
	brew bundle dump -f
	git add .
	git commit -m "Weekly update $(MMWWYY)"
	git push -u origin TM-update-$(MMWWYY)
	gh pr create --base master --title "TM-update-$(MMWWYY)" --fill
	gh pr merge "TM-update-$(MMWWYY)" --admin --merge