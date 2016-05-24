
export FASTLANE_USER=''
export FASTLANE_PASSWORD=''
export XCODE_VERSION='7.3.1'
export XCODE_SIMULATORS='"iOS 8.4"'

echo "Installing xcode-install..."
sudo gem install xcode-install
echo "Downloading and installing Xcode..."
sudo -E /usr/local/bin/xcversion install $XCODE_VERSION --verbose
echo "Downloading and installing simulators..."
sudo -E /usr/local/bin/xcversion simulators --install=$XCODE_SIMULATORS --verbose
echo "Finished installing Xcode and simulators"
