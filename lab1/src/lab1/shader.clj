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

 (defn screen-pos [n z dim]
    (let [c (/ dim 2)]; in
         (* (/ n z) (- 100 c) )))

(defn screen-x [x z]
    (screen-pos x z (q/width)))

(defn screen-y [y z]
    (screen-pos y z (q/height)))

(defn update-star [star]
    (let [z (:z star)
          y (screen-y (:y star) z)
          x (screen-x (:x star) z)]; in
        (if (or (< 0 x y z)
                (> (q/height) y) (> (q/width) x))
            (update-in star [:z] dec)
            (create-star) )))


(defn update-state [state]
        (update-in state [:stars]
            #(map update-star %1)))

(defn grey-from-z [z]
    (- 255 (* z (/ 255.0 1000.0))))

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
