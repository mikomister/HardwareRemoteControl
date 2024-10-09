/*
  Keyboard test

  Reads a byte from the serial port, sends a keystroke back.
  The sent keystroke is one higher than what's received, e.g. if you send a,
  you get b, send A you get B, and so forth.

  The circuit:
  - none

  created 21 Oct 2011
  modified 27 Mar 2012
  by Tom Igoe

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/KeyboardSerial
*/


//#define ARDUINO_USB_MODE 2
//#define SOC_USB_OTG_SUPPORTED

/*
#ifndef ARDUINO_USB_MODE
#error This ESP32 SoC has no Native USB interface
#elif ARDUINO_USB_MODE == 1
#warning This sketch should be used when USB is in OTG mode
void setup() {}
void loop() {}
#else
*/

#include "USB.h"
#include "USBHIDKeyboard.h"
#include "USBHIDMouse.h"
USBHIDKeyboard Keyboard;
USBHIDAbsoluteMouse Mouse;
//USBHIDRelativeMouse Mouse;
int mx = 0;
int my = 0;
#define RESET_BUTTON_PIN 17
#define POWER_BUTTON_PIN 18

void setup() {
  if (RESET_BUTTON_PIN) {
    pinMode(RESET_BUTTON_PIN, OUTPUT);
    digitalWrite(RESET_BUTTON_PIN, 0);
  }
  if (POWER_BUTTON_PIN) {
    pinMode(POWER_BUTTON_PIN, OUTPUT);
    digitalWrite(POWER_BUTTON_PIN, 0);
  }
/*
  pinMode(17, OUTPUT);
  pinMode(18, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(3, OUTPUT);
  digitalWrite(17, 1);
  digitalWrite(18, 1);
  digitalWrite(8, 1);
  digitalWrite(3, 1);

  pinMode(35, OUTPUT);
  pinMode(36, OUTPUT);
  pinMode(37, OUTPUT);
  pinMode(38, OUTPUT);
  digitalWrite(35, 1);
  digitalWrite(36, 1);
  digitalWrite(37, 1);
  digitalWrite(38, 1);
  */

  Serial.begin(115200);
  Keyboard.begin();
  Mouse.begin();
  USB.begin();

  delay(1000);
  Serial.write("Started!");
}

void loop() {
    if (Serial.available() > 0) {
        String line = Serial.readStringUntil('\n');
        Serial.write(line.c_str());
        Serial.write("\n");
        if (line.endsWith("\r")) {
            line = line.substring(0, line.length() - 1);
        }

        if (line.startsWith("KD:")) {
            uint8_t keyCode = (uint8_t)line.substring(3).toInt();
            Keyboard.pressRaw(keyCode);
        }
        else if (line.startsWith("KU:")) {
            uint8_t keyCode = (uint8_t)line.substring(3).toInt();
            Keyboard.releaseRaw(keyCode);
        } 
        else if (line.startsWith("KP:")) {
          String params = line.substring(3);
          int pos = params.indexOf(',');
          if (pos >= 0) {
            uint8_t keyCode = (uint8_t)params.substring(0, pos).toInt();
            int Delay = params.substring(pos + 1).toInt();
            Keyboard.pressRaw(keyCode);
            delay(Delay);
            Keyboard.releaseRaw(keyCode);
          }
        } 
        else if (line.startsWith("MW:")) {
            char pos = (char)line.substring(3).toInt();
            Mouse.move(mx, my, pos);
        }
        else if (line.startsWith("MM:")) {
            String coords = line.substring(3);
            int pos = coords.indexOf(',');
            if (pos >= 0) {
                mx = coords.substring(0, pos).toInt();
                my = coords.substring(pos + 1).toInt();
                Mouse.move(mx, my);
            }
        }
        else if (line.startsWith("MD:")) {
            String coords = line.substring(3);
            int pos = coords.indexOf(',');
            if (pos >= 0) {
                int button = coords.substring(0, pos).toInt();
                coords = coords.substring(pos + 1);
                int pos = coords.indexOf(',');

                if (pos >= 0) {
                    mx = coords.substring(0, pos).toInt();
                    my = coords.substring(pos + 1).toInt();
                    Mouse.move(mx, my);
                    Mouse.press(button);
                }
            }
        } else if (line.startsWith("MU:")) {
            String coords = line.substring(3);
            int pos = coords.indexOf(',');
            if (pos >= 0) {
                int button = coords.substring(0, pos).toInt();
                coords = coords.substring(pos + 1);
                int pos = coords.indexOf(',');
                if (pos >= 0) {
                    int x = coords.substring(0, pos).toInt();
                    int y = coords.substring(pos + 1).toInt();
                    Mouse.move(x, y);
                    Mouse.release(button);
                }
            }
        } else if (line.startsWith("RB:")) {
          if (RESET_BUTTON_PIN) {
            digitalWrite(RESET_BUTTON_PIN, 1);
            delay(250);
            digitalWrite(RESET_BUTTON_PIN, 0);
          }
        } else if (line.startsWith("PW:")) {
          if (POWER_BUTTON_PIN) {
            digitalWrite(POWER_BUTTON_PIN, 1);
            delay(250);
            digitalWrite(POWER_BUTTON_PIN, 0);
          }
        }
    }
}
//#endif /* ARDUINO_USB_MODE */
