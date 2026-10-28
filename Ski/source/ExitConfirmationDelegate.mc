import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


class ExitConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response as Confirm) as Boolean {
        if (response == WatchUi.CONFIRM_YES) {
            getApp().saveSession();
            System.exit();
        }
        return true;
    }
}
