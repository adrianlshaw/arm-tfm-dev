CUR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all:
	docker build -t tfmbuild .
	docker run -ti --rm -v $(CUR):/opt tfmbuild /bin/bash -c "cd /opt && ./build-and-run.sh"
