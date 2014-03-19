## Petrolbyte: a car enthusiast's companion

A web application that connects to your ELM327 WIFI module (other connection types, like USB, may come later) and enables you to exploit various features of the [OBD II](http://en.wikipedia.org/wiki/On-board_diagnostics#OBD-II) protocol for communicating with you car's electronic brain. I chose the WIFI version first because it has zero requirements on the operating system and drivers and stuff - just plain TCP/IP, whatever's your client device. eBay is full of them and they go for quite reasonable prices.

Written using [Racket](http://racket-lang.org), ClojureScript and Reagent / Facebook React. No database - just yet.

#### Why?

I love cars and I love to fix/do as much as I can myself. Most of the reasonably good car diagnostics software is expensive and (AFAIK) none of it is web/server-based. And most importantly: I wanted something that could run (not only) on my Raspberry Pi and could serve as a smart carputer and a diagnostic device at the same time - all accessible using just a web browser.

#### Current status

**Pre-alpha work-in-progress thing!** The app can connect to your ELM module, and reset it. Unfortunately, ELM327 does not work on a plain send/receive stateless TCP/IP basis, so the mock server that is included in this project actually works differently than the actual device. I'm studying the specs and working to fix this.

#### Howto

##### Bootstrap & sanity checks

1. Install [Racket >= 6.0](http://http://download.racket-lang.org)
2. Clone this repo
3. Compile ClojureScript sources `lein do clean, cljsbuild clean, cljsbuild once`
3. Run the ELM327 mock server that is needed for some of the tests to run properly:  
	 - `racket elm327-mock-server.rkt`
3. `cd server`
4. Run the tests: `raco test tests`

##### Running the app

5. If you want to run against a real device instead of the mock server - which does not make much of a sense now - change the config in `elm327.rkt` (you will probably only need to change the host - my device creates an ad-hoc WIFI network and sits on `192.168.0.10`)
6. Run the app: `racket app.rkt`

#### License

Eclipse Public License - v 1.0. See the LICENSE file.