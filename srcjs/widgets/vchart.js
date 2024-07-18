import "widgets";
import VChart from "@visactor/vchart";


HTMLWidgets.widget({

  name: "vchart",

  type: "output",

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        const vchart = new VChart(x.specs, { dom: el.id });
        vchart.renderAsync();

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
