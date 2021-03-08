install: reinstall
	install -v -b -Dm644 src/tpm2-luks.conf "$(DESTDIR)/etc/tpm2-luks.conf"

reinstall:
	install -Dm644 hooks/tpm2-luks "$(DESTDIR)/usr/lib/initcpio/hooks/tpm2-luks"
	install -Dm644 install/tpm2-luks "$(DESTDIR)/usr/lib/initcpio/install/tpm2-luks"

all: install
