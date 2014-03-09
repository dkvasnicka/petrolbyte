(ns petrolbyte.client.app
  (:require [reagent.core :as r]
            [jayq.core :refer [document-ready ajax]])
  (:require-macros [jayq.macros :as jqm]))

(def elm-id (r/atom "Disconnected"))

(defn connect [evt]
  (jqm/let-ajax [data {:url "/connect" :dataType :json}]
    (reset! elm-id (.-ifaceId data))))

(defn iface-id []
  [:li [:a {:href "#"} @elm-id]])

(defn main []
  [:div
    [:h3 "Welcome"]
    [:p "Click the button to connect to your car and reset the ELM 327 device."]
    [:p
     [:button
      {:type "button" 
       :class "btn btn-success btn-lg"
       :on-click connect} "Connect!"]]])

(jqm/ready
  (r/render-component [main]
                      (.getElementById js/document "mainContainer"))
  (r/render-component [iface-id]
                      (.getElementById js/document "ifaceId"))) 
