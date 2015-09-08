(ns lab1.shader
    (:require [quil.core :as q]))

(defn create-star []
    ; create a new star at the selected x-, y-, and z-position.
    ; this function should be called repeatedly when creating the initialization
    ; state, or whenever a star goes out of bounds.
    {:x (q/random 0 1000)
     :y (q/random 0 1000)
     :z (q/random 100 1000)})

(defn setup []
  ; Set frame rate to 60 frames per second.
  (q/frame-rate 60)
  {:stars (repeatedly 64 #(create-star)) })

 (defn screen-pos [n z dim]
    ; determine the screen position for an object in the
    ; simulated space in one dimension, where `n` is the x-or y-position
    ; of the object, `z` is the z-position of the object, and `dim` is the
    ; size of the screen in that dimension
    (let ; let `c` equal the screen centre in this dimension
        [c (/ 2 dim)]; in
        ; find the bias to shift the star in this dimension
         (* (/ n z)
            (+ 100 c) )))

(defn screen-x [x z]
    ; determine the screen x-position for an object with the given
    ; x- and z-positions in the simulated space
    (screen-pos x z (q/width)))

(defn screen-y [y z]
    ; determine the screen y-position for an object with the given
    ; y- and z-positions in the simulated space
    (screen-pos y z (q/height)))

(defn update-star [star]
    ; update a given star by decreasing its z-distance from the
    ; viewer, or by generating a new star if the star has moved
    ; off the screen
    (let [z (:z star)
          y (screen-y (:y star) z)
          x (screen-x (:x star) z)]; in
        (if ; if the star has left the screen's boundaries
            (or (< x 0) (< y 0) (< z 1)
                (> y (q/height)) (> x (q/width)))
            (create-star) ; replace the out of bounds star with a new one
            (update-in star [:z] dec) ; otherwise, decrease the z-distance
            )))


(defn update-state [state]
    ; update the entire state by mapping `update-star` across each star.
    ; this is called once per frame, before drawing the state.
    (update-in state [:stars]
        #(map update-star %1)))

(defn grey-from-z [z]
    ; use z-distance to fade the star
    ; so that they don't just wink into existance
    (- 255 (* z (/ 255 900))))

(defn draw-star [x y z]
    ; draws a star at position (`x`, `y`, `z`) by setting the pixel
    ; at the screen x- and y-position corresponding to that star
    ; with a grey value calculated from the star's distance
    (q/set-pixel (screen-x x z)
                 (screen-y y z)
                 (q/color (grey-from-z z))))

(defn draw-state [state]
    ; draws a state
    (q/background 0) ; reset background to black (if this is commented out,
                     ; we can get some kind of nift streaks...)
    (doseq [{x :x y :y z :z} (:stars state)] ; for each star in the state...
        (draw-star x y z))) ; ...call the `draw-star `function
