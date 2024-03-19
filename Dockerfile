FROM node:21
RUN apt-get update
RUN apt-get install -y libvips python3 neovim
RUN npm install -g sharp
RUN npm install -g sqlite3
RUN npm install -g joplin
RUN joplin config editor /usr/bin/nvim
COPY init.vim /root/.config/nvim/init.vim
COPY coc-settings.json /root/.config/nvim/coc-settings.json
COPY keymap.json /root/.config/joplin/keymap.json
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN nvim --headless +PlugInstall +qall
RUN joplin config trackLocation false
RUN joplin config editor /usr/bin/nvim

