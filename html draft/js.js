function showReplyForm(id)
{
	document.getElementById("comment"+id).innerHTML += '<br/><div class="commentChain">UKULELE!<br/><textarea class="replyInput" width="600" height="500" placeholder="Ajd, napis neki!"></textarea><br/><input type="button" value="Post reply" /></div>';
}