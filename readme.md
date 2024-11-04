[SRC, habr](https://habr.com/ru/companies/ruvds/articles/847842/)

# About

This is software part for project HardwareRemoteControl. It physically connects two computers and allow one to control another. Any OS on controlled PC (you can even enter BIOS and reinstall OS), only Windows on controlling PC.

To use it you need:
 - USB-HDMI Video Capture Device to get video from controlled pc (May be just web-camera co capture monitor, depends on how much of a freak you are:)
 - ESP32 S3 Board to emulate mouse and keyboard
![Alt text](./Images/hardware.jpg?raw=true "Image")
 - Optional 2 Relays, if you want to control Reset/Power SW on controlled PC.
![Alt text](./Images/relay.jpg?raw=true "Image")

# How To

1. You need to prepare your ESP32 S3 Device:
 - Install Arduino IDE
 - Setup Arduino IDE to work with ESP32 boards
 - Open **Sources/ESP32S3/USB-Mouse-Keyboard.ino**
 - If you use relays to control Reset/Power SW on controlled PC, solder relays to pins (I've used 17,18 you can change it in code)
 - Compile code and upload to ESP32 S3 Board
2. If you use relays to control Reset/Power SW, solder cables with 2-pin connector on the end to relays
![Alt text](./Images/2pin.png?raw=true "Image")
3. Connect devices to PC using scheme:
![Alt text](./Images/scheme.png?raw=true "Image")
4. If you use relays to control Reset/Power SW, put 2 pin connectors to FPanel on motherboard on controlled PC
![Alt text](./Images/pins.png?raw=true "Image")
5. Download, extract and run on controlling pc **Releases** or compile from source code (.Net, WinForms)
6. Select your video capture device (or webcam) and COM port with ESP32 S3, press connect. You will see picture from controlled PC's monitor and can use mouse and keyboard. It will work without any OS on controlled PC and you can even enter BIOS and install it.

# If you use camera

If you can't use USB-HDMI Video Capture Device and use camera, in image transformation section you can stretch your video to make remote screen to fit window without any borders and this will make your mouse cursor more precise.
![Alt text](./Images/transform.png?raw=true "Image")

# Tests

With USB-HDMI Video Capture Device:

![Alt text](./Images/test.gif?raw=true "Image")

With Web-Camera:

![Alt text](./Images/test2.gif?raw=true "Image")

# 3D Printed Box for ESP32 S3 With/Without Relays

You can print box for your device. Look in **Sources/3D Printed Box** folder. I've made box to use with specific relays, but it's OpenSCAD and you can change any sizes in this model. Look at variables: RelayWidth, RelayLength, RelayHeight and RelaysCount


# License

My project parts is MIT, but it uses modified AForge lib version and it's GPL/LGPL
