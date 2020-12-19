/opt/packer/1.6.6/packer build -var-file="variables-windows10-uefi.json" --only=qemu -except=vagrant /srv/packer/templates/bento/packer_templates/windows/windows-10gen2.json
/opt/packer/1.6.6/packer build -var-file="variables-fedora32-cloud-uefi.json" --only=qemu -except=vagrant /srv/packer/templates/bento/packer_templates/fedora/fedora-32-x86_64.json
/opt/packer/1.6.6/packer build -var-file="variables-fedora33-cloud-uefi.json" --only=qemu -except=vagrant /srv/packer/templates/bento/packer_templates/fedora/fedora-33-x86_64.json
/opt/packer/1.6.6/packer build -var-file="variables-fedora32-workstation-uefi.json" --only=qemu -except=vagrant /srv/packer/templates/bento/packer_templates/fedora/fedora-32-x86_64.json
/opt/packer/1.6.6/packer build -var-file="variables-fedora33-workstation-uefi.json" --only=qemu -except=vagrant /srv/packer/templates/bento/packer_templates/fedora/fedora-33-x86_64.json
