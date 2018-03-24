#!/bin/bash

#######################################
# Bash script to install an Ionic Apps
# Written by Porfirio Ángel Díaz Sánchez 
#######################################


if [ ! -f my-release-key.keystore ]; then
    echo "Creating the sign key..."
    echo ""
    keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
fi

echo "Deleting previous generated apks..."
echo ""
rm -f *.apk

echo "Generating the new apk..."
echo ""
ionic cordova build android --release

echo "Moving the generated apk to the curren working directory..."
echo ""
mv ./platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk .

echo "Signing the apk..."
echo ""
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore app-release-unsigned.apk alias_name

echo "Verificating the apk..."
echo ""
/home/porfirio/Android/Sdk/build-tools/25.0.0/zipalign -v 4 app-release-unsigned.apk Up.apk

echo "Done"