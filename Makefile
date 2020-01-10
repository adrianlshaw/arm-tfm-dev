all:
	docker run -ti --rm -v $PWD:/opt ubuntu:19.10 /bin/bash -c "cd /opt && ./setup.sh"
