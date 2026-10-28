import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


class DiscardConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response as Confirm) as Boolean {
        if (response == WatchUi.CONFIRM_YES) {
            getApp().discardSession();
            System.exit();
        }
        return true;
    }
}
