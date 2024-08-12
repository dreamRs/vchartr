import "widgets";
import VChart from "@visactor/vchart";
import { allThemeMap } from "@visactor/vchart-theme";

import {format as d3_format, formatLocale as d3_format_locale} from "d3-format";
import {timeFormatLocale as d3_time_format_locale} from "d3-time-format";

export { d3_format, d3_format_locale, d3_time_format_locale };

// register themes
allThemeMap.forEach((theme, name) => {
  VChart.ThemeManager.registerTheme(name, theme);
});


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

        // register themes
        //allThemeMap.forEach((theme, name) => {
        //  VChart.ThemeManager.registerTheme(name, theme);
        //});
        //VChart.ThemeManager.setCurrentTheme("vScreenVolcanoBlue");

        if (typeof vchart == "undefined") {
          vchart = new VChart(x.specs, { dom: el.id });
          vchart.renderAsync();
        } else {
          vchart.updateSpec(x.specs);
        }

        if (x.hasOwnProperty("theme")) {
          vchart.setCurrentTheme(x.theme);
        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
