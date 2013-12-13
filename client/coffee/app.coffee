ELMInterfaceId = React.createClass
    getInitialState: ->
        getJson.bind(@)("/connect")
        { ifaceId: "Connecting..." }

    render: -> (li {}, [(a {href: "#"}, @state.ifaceId)])

DTCTable = React.createClass
    getInitialState: ->
        getJson.bind(@)("/error-codes")
        {dtcs: [{code: "Loading..."}]}

    render: ->
        rows = @state.dtcs.map (s) ->
            (tr {}, [
                (td {}, s.code),
                (td {}, s.description)
            ])

        (table {className: "table table-bordered"}, [
            (thead {}, [
                (tr {}, [
                    (th {}, "Code"), (th {}, "Description")
                ])
            ]),
            (tbody {}, rows)
        ])

DiagnosticTroubleCodes = React.createClass
    render: ->
        (div {}, [
            (h3 {}, "Diagnostic trouble codes"),
            DTCTable {}
        ])

$(document).ready ->
    $("#dtcs").click ->
        React.renderComponent (DiagnosticTroubleCodes {}), __ "mainContainer"        

    $("#connectbtn").click ->
        React.renderComponent (ELMInterfaceId {}), __ "ifaceId"
        $("#mainContainer").empty()
