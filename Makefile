DEB_DIRS := $(wildcard packages/*/)
DEBS_FILES := $(patsubst packages/%/,./%.deb,$(DEB_DIRS))

%.deb: packages/%
	mkdir -p staging/$<
	rsync --exclude .git --exclude README.md -a $</ staging/$<
	dpkg-deb -b staging/$< $@
	rm -rf staging/$<

debian/dists/wanparty/Release: $(DEBS_FILES) 
	echo $(DEBS_FILES)
	cd debian && reprepro -Vb . includedeb wanparty ../*.deb && scp -r * sohaibafifi@ssh-sohaibafifi.alwaysdata.net:~/repo.sohaibafifi.com/debian/

.PHONY: clean cleanall
clean:
	rm -rf *.deb debian/db debian/pool debian/dists

cleanall:
	rm -rf  debian/pool debian/db debian/dists