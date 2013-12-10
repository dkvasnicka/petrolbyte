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

$("#connectbtn").click(function() {
    React.renderComponent(<ELMInterfaceId />, __("ifaceId"));
    $("#mainContainer").empty();    
});

