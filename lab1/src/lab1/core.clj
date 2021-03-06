(ns lab1.core
  (:require [quil.core :as q]
            [quil.middleware :as m]
            [lab1.shader :as shader])
  (:gen-class))


(defn -main [& args]
(q/defsketch lab1
  :title "Space!"
  :size [500 500]
  ; setup function called only once, during sketch initialization.
  :setup shader/setup
  ; update-state is called on each iteration before draw-state.
  :update shader/update-state
  :draw shader/draw-state
  :features [:keep-on-top]
  ; This sketch uses functional-mode middleware.
  :middleware [m/fun-mode]))
