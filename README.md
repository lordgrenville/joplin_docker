First build and tag the container with `docker build joplin_docker/ -t joplin`
Then run it with `docker run -it v joplin_data:/var/opt/project --name joplin joplin`
The key point here is the `-it` argument. Don't need to set an `--entrypoint`, either in the command or in the Dockerfile. The other arguments are for mounting a volume, and for giving a user-friendly name.
After that if you quit, since you didn't add the `--rm` argument, you can run `docker start joplin && docker attach joplin`.
