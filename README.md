## OS X VM Factory

This is a set of scripts and [Packer](https://www.packer.io) templates to create OS X VM for [VirtualBox](https://www.virtualbox.org). It is largely based on [osx-vm-templates](https://github.com/timsutton/osx-vm-templates). Be aware that the whole process can take more than 3 hours and require at least 30GB of disk space. We use [mas](https://github.com/argon/mas) and [xcode-install](https://github.com/neonichu/xcode-install) to automate as much as possible. *Be aware that there is an inherent security risk when we rely on third-party code to get our compilers.*

### 1. Getting Started

Clone the repository:

```
git clone https://github.com/donny/osx-vm-factory
```

Get the OS X El Capitan installer app from the Mac App Store:

```
brew install mas
mas install 1018109117 # Install OS X El Capitan
```

Install the required software:

```
brew cask install virtualbox virtualbox-extension-pack vagrant
brew install packer
```

Modify the file `scripts/xcode.sh` and fill in the appropriate credentials (use a low privilege Apple ID). These are used to download Xcode from Apple.

### 2. Building the Disk Image

Build the disk image using `prepare_iso.sh` script in `osx-vm-factory` repository. Disable remote management if we’re building an image for VirtualBox.

```
cd osx-vm-factory
sudo ./prepare_iso/prepare_iso.sh \
  -D DISABLE_REMOTE_MANAGEMENT \
  /Applications/Install\ OS\ X\ El\ Capitan.app/ \
  packer/
```

Take note of the output at the end, we need the filename (e.g. `OSX_InstallESD_10.11.5_15F34.dmg`) of the new disk image.

### 3. Packing the Vagrant Box

Use `packer` to pack the Vagrant box.

```
cd osx-vm-factory/packer
packer build \
  -var iso_url=OSX_InstallESD_10.11.5_15F34.dmg \
  -var autologin=true \
  -only virtualbox-iso \
  template.json
```

### 4. Using the Box with Vagrant

Add the box to Vagrant:

```
vagrant box add \
  --name osx-10.11.5 \
  packer_virtualbox-iso_virtualbox.box
```

Provision the box:

```
mkdir osx-vm
cp osx-vm-factory/Vagrantfile osx-vm
cd osx-vm
vagrant up
```
