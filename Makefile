setup:
	git submodule init
	git submodule update

clean:
	rm -rf ~/.gitconfig
	rm -rf ~/.oh-my-zsh
	rm oh-my-zsh/themes/returnwt.zsh-theme
	rm oh-my-zsh/themes/bullet-train.zsh-theme
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	rm -rf ~/.zshrc

clean_themes:
	rm oh-my-zsh/themes/returnwt.zsh-theme
	rm oh-my-zsh/themes/bullet-train.zsh-theme

install:
	ln -s "$(shell pwd)/gitconfig" ~/.gitconfig
	ln -s "$(shell pwd)/oh-my-zsh" ~/.oh-my-zsh
	ln -s "$(shell pwd)/zsh-theme/returnwt.zsh-theme" ~/.oh-my-zsh/themes
	ln -s "$(shell pwd)/bullet-train.zsh-theme" ~/.oh-my-zsh/themes
	ln -s "$(shell pwd)/vim" ~/.vim
	ln -s "$(shell pwd)/vimrc" ~/.vimrc
	ln -s "$(shell pwd)/zshrc" ~/.zshrc

upstream:
	cp    ~/.gitconfig  ./gitconfig
	cp    ~/.vimrc      ./vimrc
	cp    ~/.zshrc      ./zshrc
	cp    ~/.oh-my-zsh/themes/returnwt.zsh-theme ./zsh-theme/returnwt.zsh-theme
