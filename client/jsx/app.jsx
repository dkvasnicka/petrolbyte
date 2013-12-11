/** @jsx React.DOM */

var ELMInterfaceId = React.createClass({
    getInitialState: function() {
        $.getJSON("/connect", function(data) {
            this.setState(data);
        }.bind(this));

        return { ifaceId: "Connecting..." };
    },

    render: function() {
        return (
            <li><a href="#">{this.state.ifaceId}</a></li>
        );
    }
});

var DTCTable = React.createClass({
    getInitialState: function() {
        $.getJSON("/error-codes", function(data) {
            this.setState(data);
        }.bind(this));

        return {dtcs: [{code: "Loading..."}]};
    },

    render: function() {
        var rows = this.state.dtcs.map(function(s) {
            return (
                <tr>
                    <td>{s.code}</td>
                    <td>{s.description}</td>
                </tr>
            );
        });

        return (
            <table className="table table-bordered">
                <thead>
                    <tr>
                        <th>Code</th><th>Description</th>
                    </tr>    
                </thead>
                <tbody>                    
                    {rows}
                </tbody>
            </table>
        );
    }
});

var DiagnosticTroubleCodes = React.createClass({
    render: function() {
        return (
            <div>
                <h3>Diagnostic trouble codes</h3>
                <DTCTable />
            </div>    
        );
    }
});

$("#dtcs").click(function() {
    React.renderComponent(<DiagnosticTroubleCodes />, __("mainContainer"));
});

$("#connectbtn").click(function() {
    React.renderComponent(<ELMInterfaceId />, __("ifaceId"));
    $("#mainContainer").empty();    
});

