import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SkiApp extends Application.AppBase {


    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var ski_view = new $.SkiView();
        var alternate_view = new $.AlternateSkiView();
        return [ ski_view, new $.SkiDelegate(ski_view, alternate_view) ];
    }

}

function getApp() as SkiApp {
    return Application.getApp() as SkiApp;
}