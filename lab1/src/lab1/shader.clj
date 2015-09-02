(ns lab1.shader
    (:require [quil.core :as q]))

(defn create-star []
    {:x (q/random -500 500)
     :y (q/random -500 500)
     :z (q/random 100 1000)})

(defn setup []
  ; Set frame rate to 60 frames per second.
  (q/frame-rate 60)
  {:stars (repeatedly 64 #(create-star)) })

(defn update-star [star]
    (if (< 0 (:z star))
        (update-in star [:z] dec)
        (create-star)
  ))

(defn update-state [state]
        (update-in state [:stars]
            #(map update-star %1)))

(defn screen-pos [n z dim]
    (let [c (/ 2 dim)]; in
         (* (+ 100 c) (/ n z))))

(defn screen-x [x z]
    (screen-pos x z (q/width)))

(defn screen-y [y z]
    (screen-pos y z (q/height)))

(defn draw-star [x y z]
    (q/set-pixel (screen-x x z)
                 (screen-y y z)
                 (q/color 255)))

(defn draw-state [state]
    ; reset background to black
    (q/background 0)
    ; draw stars
    (doseq [{x :x y :y z :z} (:stars state)]
        ;(println (str "x: " (screen-x x z) ", y: " (screen-y y z)))
        (draw-star x y z)))
