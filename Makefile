install: reinstall

reinstall:
	install -Dm644 hooks/encrypt-tpm "$(DESTDIR)/usr/lib/initcpio/hooks/encrypt-tpm"
	install -Dm644 src/install/encrypt-tpm "$(DESTDIR)/usr/lib/initcpio/install/encrypt-tpm"

all: install
