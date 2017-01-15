function showReplyForm(id)
{
    if (document.getElementById("replyForm_" + id).style.display == "block") {
        document.getElementById("replyForm_" + id).style.display = "none";
    } else {
        document.getElementById("replyForm_" + id).style.display = "block";
    }
}