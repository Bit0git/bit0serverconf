sudo apt-get install pv unzip hdparm
curl -O https://raw.githubusercontent.com/hypriot/flash/master/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash

# Just make sure the existing is gone
rm ./user-data.yml

# Download this yaml from this repo
curl -O https://raw.githubusercontent.com/Bit0git/bit0serverconf/master/$1.user-data

// flash it
flash \
  --hostname $1 \
  --userdata ./$1.user-data.yml \
  https://github.com/hypriot/image-builder-rpi/releases/download/v1.9.0/hypriotos-rpi-v1.9.0.img.zip
