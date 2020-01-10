CUR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all:
	docker run -ti --rm -v $(CUR):/opt ubuntu:19.10 /bin/bash -c "cd /opt && ./setup.sh"
