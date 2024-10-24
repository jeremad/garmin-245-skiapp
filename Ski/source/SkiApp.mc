import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SkiApp extends Application.AppBase {

    private var _view as SkiView?;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        _view = new $.SkiView();
        return [ _view, new $.SkiDelegate(_view) ];
    }

}

function getApp() as SkiApp {
    return Application.getApp() as SkiApp;
}