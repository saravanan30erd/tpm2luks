# LUKS Full Disk Encryption using TPM 2.0

This project leverages [TPM 2.0](https://en.wikipedia.org/wiki/Trusted_Platform_Module) to store encrypted volume passphrases. You can encrypt the root OS partition or boot partition and use TPM 2.0 to store the encryption key and unlock this encrypted partition at initramfs stage during boot process.

We can store the encryption key inside the TPM and the TPM would only reveal it if the binary being booted can be trusted.
The TPM audits the boot state by the use of Platform Configuration Registers (PCRs). When you query the TPM for the encryption key during boot process, it will check whether the PCRs matches the stored PCR or not. It provides the encryption key only if current boot process state matching the stored PCRs.

Selected the below PCRs for UEFI system,
– PCR0: Core System Firmware executable code (changes when a BIOS update is performed)
– PCR2: extended or pluggable executable code
– PCR4: UEFI Boot Manager (changes when you change the boot loader executable)
– PCR7: Secure Boot State (changes when you change the secure boot status)

This was only tested and intended for:

* [Arch Linux](https://www.archlinux.org/) and its derivatives
