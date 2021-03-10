# LUKS Full Disk Encryption using TPM 2.0

This project leverages [TPM 2.0](https://en.wikipedia.org/wiki/Trusted_Platform_Module) to store encrypted volume passphrases. You can encrypt the root OS partition or boot partition and use TPM 2.0 to store the encryption key and unlock this encrypted partition at initramfs stage during boot process.

We can store the encryption key inside the TPM and it would only reveal it if the binary (BIOS and Boot loader) being booted can be trusted.
The TPM audits the boot state by the use of Platform Configuration Registers (PCRs). When you query the TPM for the encryption key during boot process, it will check whether the PCRs matches the stored PCR or not. It provides the encryption key only if current boot process state matching the stored PCRs.
The key point is that these are values which cannot be set and can only be appended. Each process in the boot (e.g. BIOS/UEFI) would append relevant configurations to the PCRs.

Selected the below PCRs for UEFI system,
* PCR0: Core System Firmware executable code (changes when a BIOS update is performed)
* PCR2: extended or pluggable executable code
* PCR4: UEFI Boot Manager (changes when you change the boot loader executable)
* PCR7: Secure Boot State (changes when you change the secure boot status)

This was only tested and intended for:

* [Arch Linux](https://www.archlinux.org/) and its derivatives
* System with [TPM 2.0](https://en.wikipedia.org/wiki/Trusted_Platform_Module)

# Prerequisites

**Warning: It's recommended to have already working [encrypted system setup](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system) with `encrypt` hook before starting to use `tpm2luks` hook with TPM 2.0 to avoid potential misconfigurations.**

## Install the dependency TPM 2.0 tools

```
pacman -S tpm2-tools tpm2-tss tpm2-abrmd
```

# Install

## From Github using 'make'

```
git clone https://github.com/saravanan30erd/tpm2luks
cd tpm2luks
make install
```

# Configure

## Edit /etc/tpm2luks.conf file

Open the /etc/tpm2luks.conf file and adjust it for your needs.

Example:

Provide the LUKS encrypted device,
```
TPM2_LUKS_DEV="/dev/sda2"
```

LUKS encrypted volume name after unlocking,
```
TPM2_LUKS_NAME="luks_boot"
```

## Enroll a secret key to existing LUKS encrypted volume and TPM 2.0

To enroll the secret key to existing *LUKS* encrypted volume and *TPM 2.0*
you can use `tpm2luks-enroll`,
see `tpm2luks-enroll -h` for help:

```
tpm2luks-enroll -d /dev/<device> -s <keyslot_number>
```

By default, it uses `keyslot 4` if you don't pass `-s <keyslot_number>`.

```
tpm2luks-enroll -d /dev/sda2
```

`tpm2luks-enroll` will generate a encryption key and enroll the key to the disk and TPM 2.0.

## Enable tpm2luks initramfs hook

Edit `/etc/mkinitcpio.conf` and add the `tpm2luks` hook before or instead of `encrypt` hook as provided in [example](https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#Examples). Adding `tpm2luks` hook before `encrypt` hook will allow for a safe fallback in case of tpm2luks misconfiguration. You can remove `encrypt` hook later when you confirm that everything is working correctly.

After making the changes, run the below command to regenerate the initramfs.

```
tpm2luks-load
```

Reboot and test your configuration.

# License

Licensed under

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or
  http://www.apache.org/licenses/LICENSE-2.0)
