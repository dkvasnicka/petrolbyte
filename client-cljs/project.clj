(defproject client-cljs "0.1.0-SNAPSHOT"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0-alpha4"]
                 [org.clojure/clojurescript "0.0-2371"]
                 [jarohen/chord "0.4.2"]
                 [reagent "0.4.2"]
                 [jayq "2.5.2"]]
  
  :cljsbuild {
    :builds [{
        :source-paths ["src"]
        :compiler {
          :output-to "../client/js/app.js"
          :optimizations :whitespace
          :pretty-print true
        }}]
  })
