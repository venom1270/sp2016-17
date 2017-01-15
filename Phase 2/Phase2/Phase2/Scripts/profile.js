

document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("changeEmailInput").addEventListener("change", emailChanged);
    var pass = document.getElementsByClassName("changePasswordInput");
    for (var i = 0; i < pass.length; i++) {
        pass[i].addEventListener("change", passwordChanged);
    }
});




function emailChanged() {
    document.getElementById("emailChangedNote").style.display = "inline-block";
}

function passwordChanged() {
    console.log("qwe");
    var pass = document.getElementsByClassName("passwordChangedNote");
    for (var i = 0; i < pass.length; i++) {
        pass[i].style.display = "inline-block";
    }
}