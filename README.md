## Petrolbyte: a car enthusiast's companion

A web application that connects to your ELM327 WIFI module in order to exploit various features of the [OBD II](http://en.wikipedia.org/wiki/On-board_diagnostics#OBD-II) protocol for communicating with you car's electronic brain. I chose the WIFI version first because it has zero requirements on the operating system and drivers and stuff - just plain TCP/IP, whatever's your client device.

#### Why?

I love cars and I love to fix/do as much as I can myself. Most of the reasonably good car diagnostics software is expensive and I wanted something that could run (not only) on my Raspberry Pi and could serve as a smart carputer and a diagnostic device at the same time - all accessible using just a web browser.

#### Current status

Right now, the app can connect to your ELM module and show you realtime [RPM](https://youtu.be/gvfwIWWEYTk), speed and fuel consumption (based on MAF sensor). There is also a recorder script that will record various stats and write them to STDOUT as JSON oneliners.

#### Howto

##### Prerequisities

* [Racket >= 6.6](http://racket-lang.org) (will probably work with any 6.x but all the recent code changes were only tested with 6.6)
* [Coffee-React](https://github.com/jsdf/coffee-react)

##### Running the web app

1. Compile the CJSX files in `client/js`
5. Change the host & port config in `server/elm327.rkt`, if needed
1. Plug your ELM327 module into your car and fire it up
6. Connect your computer to the network created by the dongle, setup static IP and run the app: `racket app.rkt`

If you just want to tun the recorder, edit network settings, run it and pipe it into a file. The recorder only writes data when the speed of the car is > 0 km/h.

#### License

Eclipse Public License - v 1.0. See the LICENSE file.
