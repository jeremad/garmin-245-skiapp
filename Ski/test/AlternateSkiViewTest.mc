import Toybox.Activity;
import Toybox.Lang;
import Toybox.Test;


(:test)
function alternateSkiViewShowsDistanceAscentAndDescent(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.elapsedDistance = 2500.0;
    info.totalAscent = 120;
    info.totalDescent = 850;
    var view = new AlternateSkiView();
    view.compute(info);
    Test.assertEqual("2.5 km", view.getField2());
    Test.assertEqual("120 mD+", view.getField3());
    Test.assertEqual("850 mD-", view.getField4());
    return true;
}

(:test)
function alternateSkiViewResetsWhenDataIsMissing(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.elapsedDistance = 2500.0;
    info.totalAscent = 120;
    info.totalDescent = 850;
    var view = new AlternateSkiView();
    view.compute(info);
    view.compute(new Activity.Info());
    Test.assertEqual("0.0 km", view.getField2());
    Test.assertEqual("0 mD+", view.getField3());
    Test.assertEqual("0 mD-", view.getField4());
    return true;
}
