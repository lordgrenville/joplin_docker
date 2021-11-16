FROM node:16
RUN npm install -g sharp
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN npm install -g sqlite3
RUN npm install -g joplin
# RUN joplin
