import "widgets";
import VChart from "@visactor/vchart";


HTMLWidgets.widget({

  name: "vchart",

  type: "output",

  factory: function(el, width, height) {

    let vchart;

    return {

      renderValue: function(x) {

        if (x.hasOwnProperty("map")) {
          VChart.registerMap(x.map.name, x.map.topojson, {
            type: "topojson",
            object: "map"
          });
        }

        if (typeof vchart == "undefined") {
          vchart = new VChart(x.specs, { dom: el.id });
          vchart.renderAsync();
        } else {
          vchart.updateSpec(x.specs);
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
