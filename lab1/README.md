# CMPSC382 Lab 1 - Hawk Weisman

For the first CMPSC382 lab assignment, I created an animation that 'simulates' flying through space, like the `starfield` screen saver that ships with Windows. The stars are simulated as though they exist in a three-dimensional space, with an x-, y-, and z-dimension, and projected onto the 2D screen. Stars that are 'farther away' from the viewer in the z-dimension are dimmed according to their z-distance. As the program runs, the stars are moved towards the viewer to simulate flying through space, with new stars being generated randomly as old ones leave the screen boundary.

To create a static animation of the starfield, the `update-state` function body can be commented out, disabling the animation.

Since I was already familiar with programming in Processing, I chose to use [Quil](http://quil.info/), a library for the Clojure programming language that wraps Processing and provides access to its functions. I've been meaning to learn more about Clojure for some time, and this assignment gave me a good opportunity to practice programming in that language.

## Usage

In order to run this program, you will need [`leiningen`](https://github.com/technomancy/leiningen), the Clojure build tool, installed on your system.

LightTable - open `core.clj` and press `Ctrl+Shift+Enter` to evaluate the file.

Emacs - run cider, open `core.clj` and press `C-c C-k` to evaluate the file.

REPL - run `(require 'lab1.core)`.
