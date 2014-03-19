(ns petrolbyte.client.app
  (:require [reagent.core :as r]
            [jayq.core :refer [document-ready ajax]])
  (:require-macros [jayq.macros :as jqm]))

(def elm-id (r/atom "Disconnected"))
(def dtcs   (r/atom []))

(defn connect [evt]
  (jqm/let-ajax [data {:url "/connect" :dataType :json}]
    (reset! elm-id (.-ifaceId data))))

(defn tbody [codes]
  (map #(vector :tr 
                {:key (.-code %)} 
                [:td (.-code %)] [:td (.-description %)]) 
        codes))

(defn dtc-table []
  [:table {:class "table table-bordered"}
    [:thead
      [:tr [:th "Code"] [:th "Description"]]]
    (tbody @dtcs)])

(defn troublecodes []
  [:div
    [:h3 "Diagnostic trouble codes"]
    [dtc-table]])

(defn render-dtcs [evt]
  (jqm/let-ajax [data {:url "/error-codes" :dataType :json}]
    (reset! dtcs (.-dtcs data))
    (r/render-component [troublecodes] 
                        (.getElementById js/document "mainContainer"))))

(defn iface-id []
  [:ul {:class "nav navbar-nav navbar-right"}
    [:li [:a {:href "#"} @elm-id]]])

(defn navbar []
  [:ul {:class "nav navbar-nav"}
    [:li [:a {:href "#" :on-click render-dtcs} "Trouble codes"]]])

(defn topbar []
  [:div
    [navbar]
    [iface-id]])

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
  (r/render-component [topbar]
                      (.getElementById js/document "navbar-area"))
  (r/render-component [main]
                      (.getElementById js/document "mainContainer"))) 
