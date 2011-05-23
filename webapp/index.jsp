<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Vast Challenge - InfoVis</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="http://www.openlayers.org/api/OpenLayers.js"></script>
<script type="text/javascript">
	var map;
	function init() {
		map = new OpenLayers.Map('map');

		var options = {
			numZoomLevels : 3,
			 projection:"EPSG:4326"
		};

		var graphic = new OpenLayers.Layer.Image('City Lights',
				'http://localhost:8080/vast-challenge/map/Vastopolis_Map.png',
				new OpenLayers.Bounds(-180, -88.759, 180, 88.759),
				//new OpenLayers.Bounds(42.3017, -93.5673, 42.1609, -93.1932),
				new OpenLayers.Size(580, 288), options);

		graphic.events.on({
			loadstart : function() {
				OpenLayers.Console.log("loadstart");
			},
			loadend : function() {
				OpenLayers.Console.log("loadend");
			}
		});

		var jpl_wms = new OpenLayers.Layer.WMS("NASA Global Mosaic",
				"http://t1.hypercube.telascience.org/cgi-bin/landsat7", {
					layers : "landsat7"
				}, options);

		map.addLayers([ graphic, jpl_wms ]);
		map.addControl(new OpenLayers.Control.LayerSwitcher());
		map.zoomToMaxExtent();
	}
</script>
</head>

<body onload="init()">
	<h1 id="title">Image Layer Example</h1>


	<div id="map" class="smallmap"></div>

</body>
</html>