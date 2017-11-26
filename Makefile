DEB_DIRS := $(wildcard packages/*/)
DEBS_FILES := $(patsubst packages/%/,./%.deb,$(DEB_DIRS))

%.deb: packages/%
	dpkg-deb -b $< $@

repo: $(DEBS_FILES)
	echo $(DEBS_FILES)
	cd debian && reprepro -Vb . includedeb wanparty ../*.deb 

.PHONY: clean
clean:
	rm -rf *.deb debian/pool debian/db debian/dists