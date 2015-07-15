revStream = Kefir.withInterval 1000,
    (emitter) ->
        $.getJSON "/engine-rpm", (data) -> emitter.emit data

revProperty = revStream.toProperty -> { engineRpm : 0 }

RevDisplay = React.createClass {
    mixins: [ KefirConnect(revProperty, "revdata") ],
    render: ->
        <span>{ @state.revdata.engineRpm }</span>
}

$(document).ready ->
    React.render <RevDisplay />, document.getElementById("revs")
