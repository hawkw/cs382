(ns lab1.shader
    (:require [quil.core :as q]))

(defn create-star []
    {:x (q/random 0 1000)
     :y (q/random 0 1000)
     :z (q/random 100 1000)})

(defn setup []
  ; Set frame rate to 60 frames per second.
  (q/frame-rate 60)
  {:stars (repeatedly 64 #(create-star)) })

 (defn screen-pos [n z dim]
    ; let c equal the screen centre in this dimension
    (let [c (/ 2 dim)]; in
    ; find the bias to shift the star in this dimension
         (* (/ n z)
            (+ 100 c) )))

(defn screen-x [x z]
    (screen-pos x z (q/width)))

(defn screen-y [y z]
    (screen-pos y z (q/height)))

(defn update-star [star]
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
        (update-in state [:stars]
            #(map update-star %1)))

(defn grey-from-z [z]
    ; use z-distance to fade the star
    ; so that they don't just wink into existance
    (- 255 (* z (/ 255 900))))

(defn draw-star [x y z]
    (q/set-pixel (screen-x x z)
                 (screen-y y z)
                 (q/color (grey-from-z z))))

(defn draw-state [state]
    ; reset background to black
    (q/background 0)
    ; draw stars
    (doseq [{x :x y :y z :z} (:stars state)]
        ; (println (str "x: " (screen-x x z) ", y: " (screen-y y z)))
        (draw-star x y z)))
