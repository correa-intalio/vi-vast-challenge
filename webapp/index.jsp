<html>

<head>

<title>Vast Challenge</title>
<style type="text/css">
#map {
	width: 900px;
	height: 458px;
	border: 1px solid black;
}

div.olControlMousePosition {
	font-family: Times;
	font-size: 0.75em;
	color: black;
}

div.olControlScaleLine {
	font-family: Times;
	font-size: 0.75em;
	color: red;
}
</style>
<script src="http://openlayers.org/api/OpenLayers.js"></script>
<script type="text/javascript">
	/* 	//
	 //		var lat = 93.381407;
	 var lon = 42.230864;
	 var zoom = 1;

	 var options = {
	 maxResolution : "auto",
	 maxExtent : new OpenLayers.Bounds(93.1923, 93.5673, 42.1609,
	 42.3017)
	 };
	 */
	var map;
	function init() {
		var lat = -93.381407;
		var lon = 42.230864;
		var zoom = 0;
		var options = {
			minResolution : "auto",
			minExtent : new OpenLayers.Bounds(-93.5673, 42.1609, -93.1923,
					42.3017),
			maxResolution : "0.00004717",
			//resolution: "0.00004717",
			//resolutions : [ 0.00004717 ],
			maxExtent : new OpenLayers.Bounds(-93.5673, 42.1609, -93.1923,
					42.3017)	
		};

		map = new OpenLayers.Map('map', options);

		map.addControl(new OpenLayers.Control.LayerSwitcher({
			'ascending' : false
		}));

		map.addControl(new OpenLayers.Control.MousePosition());

		map.addControl(new OpenLayers.Control.PanZoom());

		map.addControl(new OpenLayers.Control.ScaleLine());

		var ol_wms = new OpenLayers.Layer.WMS("OpenLayers WMS",
				"http://vmap0.tiles.osgeo.org/wms/vmap0", {
					layers : 'basic'
				});

		var featurecollection = {
			"type" : "FeatureCollection",
			"features" : [ {
				"geometry" : {
					"type" : "GeometryCollection",
					"geometries" : [
							{
								"type" : "LineString",
								"coordinates" : [ [ -93.5673, 42.1609 ],
										[ -93.1923, 42.3017 ] ]
							},
							/* 							{
							 "type" : "Polygon",
							 "coordinates" : [ [ [ -93.5673, 42.3017 ],
							 [ -93.1932, 42.3017 ],
							 [ -93.1932, 41.1609 ],
							 [ -93.5673, 42.1609 ] ] ]
							 }, 
							 */{
								"type" : "Point",
								"coordinates" : [ -93.5673, 42.3017 ]
							}, {
								"type" : "Point",
								"coordinates" : [ -93.1932, 42.3017 ]
							}, {
								"type" : "Point",
								"coordinates" : [ lat, lon ]
							}, {
								"type" : "Point",
								"coordinates" : [ -93.5673, 42.1609 ]
							}, {
								"type" : "Point",
								"coordinates" : [ -93.1932, 42.1609 ]
							} ]
				},
				"type" : "Feature",
				"properties" : {}
			} ]
		};
		var geojson_format = new OpenLayers.Format.GeoJSON();
		var vector_layer = new OpenLayers.Layer.Vector();
		var options = {
			numZoomLevels : 2,
			maxResolution : "0.00004717"
		};

		var graphic = new OpenLayers.Layer.Image('Vastopolis Map',
		 'http://localhost:8080/vast-challenge/map/Vastopolis_Map.png',
		 new OpenLayers.Bounds(-93.5673, 42.1609, -93.1923,
		 42.3017),
		 new OpenLayers.Size(5216, 2653), options);

		 graphic.events.on({
		 loadstart : function() {
		 OpenLayers.Console.log("loadstart");
		 },
		 loadend : function() {
		 OpenLayers.Console.log("loadend");
		 }
		 });
		 
		map.addLayers([ /*ol_wms, */vector_layer, graphic]);

		vector_layer.addFeatures(geojson_format.read(featurecollection));

		//map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
		//map.zoomToExtent();
		map.zoomToMaxExtent();
	}
</script>
</head>



<body onload="init()">

	<div id="map"></div>

</body>
</html>



