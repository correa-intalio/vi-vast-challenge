
<html>
<head>
<title>Focus + Context</title>
<link type="text/css" rel="stylesheet" href="ex.css?3.2" />
<script type="text/javascript" src="protovis-r3.2.js"></script>
<script type="text/javascript">
	var start = new Date(1990, 1, 1);
	//alert(start);
	var year = 1000 * 60 * 60 * 24 * 365;
	//alert(year);
	var data = pv.range(0, 20, .02)
			.map(
					function(x) {
						return {
							x : new Date(start.getTime() + year * x),
							y : (1 + .1 * (Math.sin(x * 2 * Math.PI)) + Math
									.random() * .1)
									* Math.pow(1.18, x) + Math.random() * .1
						};
					});
	data = [ {
		x : new Date(1990, 1, 1),
		y : 100
	}
	, {
		x : new Date(1990, 1, 2),
		y : 200
	}
	, {
		x : new Date(1990, 1, 3),
		y : 300
	}
	, {
		x : new Date(1990, 1, 4),
		y : 500
	}
	, {
		x : new Date(1990, 1, 5),
		y : 100
	}
	, {
		x : new Date(1990, 1, 6),
		y : 200
	}
	, {
		x : new Date(1990, 1, 7),
		y : 400
	}
	, {
		x : new Date(1990, 1, 8),
		y : 500
	}
	, {
		x : new Date(1990, 1, 9),
		y : 800
	}
	, {
		x : new Date(1990, 1, 10),
		y : 600
	}
	, {
		x : new Date(1990, 1, 11),
		y : 500
	}
	, {
		x : new Date(1990, 1, 12),
		y : 150
	}
	, {
		x : new Date(1990, 1, 13),
		y : 200
	}
	, {
		x : new Date(1990, 1, 14),
		y : 600
	} ];
	var end = data[data.length - 1].x;
</script>

<style type="text/css">
#fig {
	width: 860px;
	height: 390px;
}
</style>
</head>
<body>
	<div id="center">
		<div id="fig">
			<div style="text-align: right; padding-right: 20;">
				<input checked id="scale" type="checkbox" onchange="vis.render()"><label
					for="scale">Scale to fit</label>
			</div>
			<script type="text/javascript+protovis"> 
 



/* Scales and sizing. */
var w = 810,
    h1 = 300,
    h2 = 30,
    x = pv.Scale.linear(start, end).range(0, w),
    y = pv.Scale.linear(0, pv.max(data, function(d) d.y)).range(0, h2);
 
/* Interaction state. Focus scales will have domain set on-render. */
var i = {x:200, dx:100},
    fx = pv.Scale.linear().range(0, w),
    fy = pv.Scale.linear().range(0, h1);
 
/* Root panel. */
var vis = new pv.Panel()
    .width(w)
    .height(h1 + 20 + h2)
    .bottom(20)
    .left(30)
    .right(20)
    .top(5);
 
/* Focus panel (zoomed in). */
var focus = vis.add(pv.Panel)
    .def("init", function() {
        var d1 = x.invert(i.x),
            d2 = x.invert(i.x + i.dx),
            dd = data.slice(
                Math.max(0, pv.search.index(data, d1, function(d) d.x) - 1),
                pv.search.index(data, d2, function(d) d.x) + 1);
        fx.domain(d1, d2);
        fy.domain(scale.checked ? [0, pv.max(dd, function(d) d.y)] : y.domain());
        return dd;
      })
    .top(0)
    .height(h1);
 
/* X-axis ticks. */
focus.add(pv.Rule)
    .data(function() fx.ticks())
    .left(fx)
    .strokeStyle("#eee")
  .anchor("bottom").add(pv.Label)
    .text(fx.tickFormat);
 
/* Y-axis ticks. */
focus.add(pv.Rule)
    .data(function() fy.ticks(7))
    .bottom(fy)
    .strokeStyle(function(d) d ? "#aaa" : "#000")
  .anchor("left").add(pv.Label)
    .text(fy.tickFormat);
 
/* Focus area chart. */
focus.add(pv.Panel)
    .overflow("hidden")
  .add(pv.Area)
    .data(function() focus.init())
    .left(function(d) fx(d.x))
    .bottom(1)
    .height(function(d) fy(d.y))
    .fillStyle("lightsteelblue")
  .anchor("top").add(pv.Line)
    .fillStyle(null)
    .strokeStyle("steelblue")
    .lineWidth(2);
 
/* Context panel (zoomed out). */
var context = vis.add(pv.Panel)
    .bottom(0)
    .height(h2);
 
/* X-axis ticks. */
context.add(pv.Rule)
    .data(x.ticks())
    .left(x)
    .strokeStyle("#eee")
  .anchor("bottom").add(pv.Label)
    .text(x.tickFormat);
 
/* Y-axis ticks. */
context.add(pv.Rule)
    .bottom(0);
 
/* Context area chart. */
context.add(pv.Area)
    .data(data)
    .left(function(d) x(d.x))
    .bottom(1)
    .height(function(d) y(d.y))
    .fillStyle("lightsteelblue")
  .anchor("top").add(pv.Line)
    .strokeStyle("steelblue")
    .lineWidth(2);
 
/* The selectable, draggable focus region. */
context.add(pv.Panel)
    .data([i])
    .cursor("crosshair")
    .events("all")
    .event("mousedown", pv.Behavior.select())
    .event("select", focus)
  .add(pv.Bar)
    .left(function(d) d.x)
    .width(function(d) d.dx)
    .fillStyle("rgba(255, 128, 128, .4)")
    .cursor("move")
    .event("mousedown", pv.Behavior.drag())
    .event("drag", focus);
 
vis.render();
 
    </script>
		</div>
	</div>
</body>
</html>
