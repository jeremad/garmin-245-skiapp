import Toybox.Activity;
import Toybox.Lang;
import Toybox.Test;


(:test)
function skiViewShowsHeartRate(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.currentHeartRate = 142;
    var view = new SkiView();
    view.compute(info);
    Test.assertEqual("142 bpm", view.getField2());
    return true;
}

(:test)
function skiViewConvertsSpeedToKmh(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.currentSpeed = 10.0;
    var view = new SkiView();
    view.compute(info);
    Test.assertEqual("36.0 km/h", view.getField3());
    return true;
}

(:test)
function skiViewFormatsTimerTime(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.timerTime = ((1 * 60 + 2) * 60 + 3) * 1000;
    var view = new SkiView();
    view.compute(info);
    Test.assertEqual("01:02:03", view.getField4());
    return true;
}

(:test)
function skiViewResetsWhenDataIsMissing(logger as Logger) as Boolean {
    var info = new Activity.Info();
    info.currentHeartRate = 142;
    info.currentSpeed = 10.0;
    info.timerTime = 60000;
    var view = new SkiView();
    view.compute(info);
    view.compute(new Activity.Info());
    Test.assertEqual("0 bpm", view.getField2());
    Test.assertEqual("0.0 km/h", view.getField3());
    Test.assertEqual("00:00:00", view.getField4());
    return true;
}
