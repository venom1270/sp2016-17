window.onload = function() {
	initPostsEventListeners();
	initVotingEventListeners();
}

function initPostsEventListeners() {
	
	var postReplyBtns = document.getElementsByClassName("btnPostReply");
	//console.log(postReplyBtns)
	for (var i = 0; i < postReplyBtns.length; i++) {
		postReplyBtns[i].addEventListener("click", postReply);
	}
	
	document.getElementById("btnPostComment").addEventListener("click", postComment);
	document.getElementById("btnPostComment").addEventListener("click", postComment);
	
}


function postComment(event) {
	
	var section = document.getElementsByTagName("section")[0];
	var commentTextarea = section.getElementsByTagName("textarea")[0];
	var content = commentTextarea.value;
	commentTextarea.value = "";
	
	var rId = section.getElementsByTagName("article").length + 1;
	var newReplyId = "replyForm"+rId;
	
	section.innerHTML += '<article class="commentChain" id="comment'+rId+'">\
					<div class="voteDiv"><span class="voteNumber">156</span><div class="upvoteArrow" class="voteArrow"></div><div class="downvoteArrow" class="voteArrow"></div></div> \
					<div class="postContent"><p>'+content+'</p></div>\
					<div class="postDetails"><span>Posted on 3.1.2016 8:35</span> | <span>Posted by HARDCODE</span> | <a class="replyClick" onclick="showReplyForm(\''+rId+'\')"><span>Reply</span></a></div>\
					<div id="'+newReplyId+'" class="postContent commentChain padding5 reply"><textarea class="replyInput" placeholder="Type reply text here!"></textarea><br/><input type="button" data-replyTo="'+rId+'" id="btnPostReply_'+rId+'" class="btnPostReply" value="Post reply" /></div>\
				</article>';
				
	/*document.getElementById(event.target.id).addEventListener("click", postComment, event);
	document.getElementById(newReplyId).getElementsByClassName("btnPostReply")[0].addEventListener("click", postReply, event);*/
	initPostsEventListeners();
	initVotingEventListeners();
}

function postReply(event) {
	//console.log(event);
	var id = event.target.getAttribute("data-replyTo");
	var docId = "comment"+id;
	console.log(document.getElementById(docId).getElementsByTagName("article"));
	
	var commentTextarea = document.getElementById("replyForm"+id).getElementsByTagName("textarea")[0];
	var content = commentTextarea.value;
	commentTextarea.value = "";
	
	showReplyForm(id);
	
	var numReplies = document.getElementById(docId).getElementsByTagName("article").length;
	var rId = id+"_"+((numReplies)+1);
	var newReplyId = "replyForm"+rId;
	console.log(rId);
	
	
	document.getElementById("comment"+id).innerHTML += '<article class="commentChain" id="comment'+rId+'">\
					<div class="voteDiv"><span class="voteNumber">0</span><div class="upvoteArrow" class="voteArrow"></div><div class="downvoteArrow" class="voteArrow"></div></div> \
					<div class="postContent"><p>'+content+'</p></div>\
					<div class="postDetails"><span>Posted on 3.1.2016 8:35</span> | <span>Posted by HARDCODE</span> | <a class="replyClick" onclick="showReplyForm(\''+rId+'\')"><span>Reply</span></a></div>\
					<div id="'+newReplyId+'" class="postContent commentChain padding5 reply"><textarea class="replyInput" placeholder="Type reply text here!"></textarea><br/><input type="button" data-replyTo="'+rId+'" id="btnPostReply_'+rId+'" class="btnPostReply" value="Post reply" /></div>\
				</article>';
	/*document.getElementById(event.target.id).addEventListener("click", postReply, event);
	document.getElementById(newReplyId).getElementsByClassName("btnPostReply")[0].addEventListener("click", postReply, event);*/
	initPostsEventListeners();
	initVotingEventListeners();
}

function showReplyForm(id)
{
	//document.getElementById("comment"+id).innerHTML += '<br/><div class="commentChain">Reply<br/><textarea class="replyInput" width="600" height="500" placeholder="Type reply text here!"></textarea><br/><input type="button" value="Post reply" /></div>';
	if (document.getElementById("replyForm"+id).style.display == "block") {
		document.getElementById("replyForm"+id).style.display = "none";
	} else {
		document.getElementById("replyForm"+id).style.display = "block";
	}
}