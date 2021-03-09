install: reinstall
	install -v -b -Dm644 src/tpm2luks.conf "$(DESTDIR)/etc/tpm2luks.conf"

reinstall:
	install -Dm644 hooks/tpm2luks "$(DESTDIR)/usr/lib/initcpio/hooks/tpm2luks"
	install -Dm644 install/tpm2luks "$(DESTDIR)/usr/lib/initcpio/install/tpm2luks"
	install -Dm755 src/tpm2luks-enroll "$(DESTDIR)/usr/bin/tpm2luks-enroll"
	install -Dm755 src/tpm2luks-load "$(DESTDIR)/usr/bin/tpm2luks-load"

all: install
