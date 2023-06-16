# ASM_UART_Virtual_Keyboard

The UART_VirtuelnaKlavijatura project is an assembly code program written for Arduino. 
It aims to create a virtual keyboard where we can play music using the computer keyboard. 
The corresponding tone is produced on the Arduino and played through a speaker using 
a transistor amplifier.

Functionality
The project utilizes UART communication to receive keyboard input from a computer. 
Each key press corresponds to a specific musical note. The program detects the received key
and generates the appropriate tone on the Arduino. The generated tone is then played 
through the connected speaker using pulse-width modulation (PWM) and a transistor amplifier.

Hardware Setup
- Connect the Arduino's UART pins (TX and RX) to the corresponding UART pins on the computer.
- Connect a speaker or audio output device to the Arduino's digital pin 5 and ground.
- Ensure that the baud rate settings in the code match the settings of the UART communication on the computer.
- 
Getting Started
1. Set up the necessary hardware connections as described above.
2. Upload the code to the Arduino using the Arduino IDE or suitable programming software.
3. Open a serial terminal on your computer (e.g., HTerm, PuTTY) and configure it to the correct baud rate (9600).
4. Start pressing the keys on your computer keyboard, and the corresponding musical notes will be played through 
the connected speaker.

Note-to-Tone Mapping
The project uses a specific mapping of keyboard keys to musical notes. Each key corresponds to a specific frequency,
and the Arduino generates the corresponding tone based on the received key. Here's the mapping used in this project:

- Q: C4
- W: D4
- E: E4
- R: F4
- T: G4
- Z: A4
- U: B4
- I: C5

Customization
You can customize the note-to-tone mapping or add more keys and tones by modifying the code 
accordingly. Adjusting the delay between tones (delay_ton) allows for different musical effects and timing.

Please note that this project assumes ASCII input from the serial terminal. Ensure that your terminal is 
configured to send ASCII characters.

Refer to the comments within the code for further details on specific sections and instructions.

Enjoy playing music with the virtual keyboard and have fun experimenting with different tunes and melodies!
