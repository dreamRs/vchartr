import "widgets";
import VChart from "@visactor/vchart";

import {format as d3_format, formatLocale as d3_format_locale} from "d3-format";
import {timeFormatLocale as d3_time_format_locale} from "d3-time-format";

export { d3_format, d3_format_locale, d3_time_format_locale };

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
