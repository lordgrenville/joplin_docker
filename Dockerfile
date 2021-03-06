FROM node:17
RUN apt update
RUN apt install -y libvips python neovim
RUN npm install -g sharp
RUN npm install -g sqlite3
RUN npm install -g joplin
RUN joplin config editor /usr/bin/nvim
COPY init.vim /root/.config/nvim/init.vim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN nvim --headless +PlugInstall +qall
