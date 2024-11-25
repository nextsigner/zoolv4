import QtQuick 2.0

Item{
    id: r

    //Capitalize First Letter
    function cfl(string) {
        if (!string) return "";
        return string.charAt(0).toUpperCase() + string.slice(1);
    }
}
