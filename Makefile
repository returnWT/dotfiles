EXCLUDES := configs/. configs/..
DOTFILES := $(filter-out $(EXCLUDES), $(wildcard configs/.*))

install:
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	curl -fLo ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	cp -Rfv $(DOTFILES) ${HOME}
	# cp -Rfv bin/* ${HOME}/bin
