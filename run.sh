#docker run -i -t -v ~/.he-dev:/root/.he-dev dsldev:latest
docker run --rm -i -t \
    -v ~/.ssh:/home/user/.ssh:ro \
    -v ~/.he-dev:/home/user/.he-dev \
    -v ~/code:/home/user/code \
    ajmezza9/dsldev:latest