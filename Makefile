DEB_DIRS := $(wildcard packages/*/)
DEBS_FILES := $(patsubst packages/%/,./%.deb,$(DEB_DIRS))

%.deb: packages/%
	dpkg-deb -b $< $@

debian/dists/wanparty/Release: $(DEBS_FILES) 
	echo $(DEBS_FILES)
	cd debian && reprepro -Vb . includedeb wanparty ../*.deb 

.PHONY: clean cleanall
clean:
	rm -rf *.deb 

cleanall:
	rm -rf  debian/pool debian/db debian/dists