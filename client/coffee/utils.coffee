__ = (s) -> document.getElementById s

{div, h3, textarea, h1, table, p, thead, tbody, th, tr, td, li, a} = React.DOM

getJson = (url) ->
    $.getJSON url, ((data) -> @setState data).bind @
