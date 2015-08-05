dataStream = Kefir.withInterval 1000,
    (emitter) ->
        $.getJSON "/data", (data) -> emitter.emit data

dataProp = dataStream.toProperty -> { engineRpm : 0, speed: 0, fuelCons: "∞" }

DataDisplay = React.createClass {
    mixins: [ KefirConnect(dataProp, "data") ],
    render: ->
        <ul>
            <li>{ @state.data.engineRpm } RPM</li>
            <li>{ @state.data.speed } km / h</li>
            <li>{ @state.data.fuelCons } l / 100 km</li>
        </ul>
}

$(document).ready ->
    React.render <DataDisplay />, document.getElementById("data")
