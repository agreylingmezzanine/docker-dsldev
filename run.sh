#docker run -i -t -v ~/.he-dev:/root/.he-dev dsldev:latest
docker run --rm -i -t \
    -v ~/.ssh:/home/user/.ssh:ro \
    -v ~/.he-dev:/home/user/.he-dev \
    -v ~/local_sourcecode:/sourcecode \
    ajmezza9/dsldev:latest
