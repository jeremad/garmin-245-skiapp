import Toybox.Activity;
import Toybox.ActivityRecording;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Position;
import Toybox.WatchUi;

class SkiApp extends Application.AppBase {

    private var _session = null as Session?;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
        // Start acquiring GPS right away so a fix is ready before the session starts
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    function onStop(state as Dictionary?) as Void {
        saveSession();
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition(info as Position.Info) as Void {
    }

    function getSession() as Session? {
        return _session;
    }

    function toggleSession() as Void {
        if (!(Toybox has :ActivityRecording)) {
            return;
        }
        if (_session == null) {
            _session = ActivityRecording.createSession({
                :name=>"Ski",
                :sport=>Activity.SPORT_ALPINE_SKIING,
            });
            _session.start();
        } else if (_session.isRecording()) {
            _session.stop();
        } else {
            _session.start();
        }
    }

    function saveSession() as Void {
        if (_session != null) {
            if (_session.isRecording()) {
                _session.stop();
            }
            _session.save();
            _session = null;
        }
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var views = [ new $.SkiView(), new $.AlternateSkiView(), new $.TimeOfDayView() ] as Array<BaseView>;
        return [ views[0], new $.SkiDelegate(views) ];
    }

}

function getApp() as SkiApp {
    return Application.getApp() as SkiApp;
}
