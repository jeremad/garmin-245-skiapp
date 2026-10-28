import Toybox.Lang;
import Toybox.WatchUi;


class SkiDelegate extends WatchUi.BehaviorDelegate {

    private var _views as Array<BaseView>;
    private var _current_view = 0;
    private const _transition = WatchUi.SLIDE_IMMEDIATE;

    function initialize(views as Array<BaseView>) {
        BehaviorDelegate.initialize();
        _views = views;
    }

    // Index of the page `step` pages away from `index`, wrapping around at both ends
    static function pageIndex(index as Number, step as Number, count as Number) as Number {
        return ((index + step) % count + count) % count;
    }

    function onSelect() {
        getApp().toggleSession();
        WatchUi.requestUpdate();
        return true;
    }

    function switchPage(step as Number) as Void {
        _current_view = pageIndex(_current_view, step, _views.size());
        WatchUi.switchToView(_views[_current_view], self, _transition);
    }

    function onNextPage() {
        switchPage(1);
        return true;
    }

    function onPreviousPage() {
        switchPage(-1);
        return true;
    }

    function onBack() {
        if (getApp().getSession() == null) {
            // Nothing to save: let the default behavior pop the only view and exit
            return false;
        }
        WatchUi.pushView(ExitMenuDelegate.createMenu(), new $.ExitMenuDelegate(), _transition);
        return true;
    }
}
