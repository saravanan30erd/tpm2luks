install: reinstall

reinstall:
	install -Dm644 hooks/tpm2-luks "$(DESTDIR)/usr/lib/initcpio/hooks/tpm2-luks"
	install -Dm644 install/tpm2-luks "$(DESTDIR)/usr/lib/initcpio/install/tpm2-luks"

all: install
