document.addEventListener("DOMContentLoaded", function() {
	initVotingEventListeners();
});

var voteObject;
var voteBuffer;

function initVotingEventListeners() {
	var upvoteArrows = document.getElementsByClassName("upvoteArrow");
	for (var i = 0; i < upvoteArrows.length; i++) {
		upvoteArrows[i].addEventListener("click", upvoteArticle);
	}
	
	var downvoteArrows = document.getElementsByClassName("downvoteArrow");
	for (var i = 0; i < upvoteArrows.length; i++) {
		downvoteArrows[i].addEventListener("click", downvoteArticle);
	}
	
}

function insertVote() {
	voteObject.innerHTML = voteBuffer;
	initVotingEventListeners();
}

function upvoteArticle(event) {
	console.log("Upvote");
	event.target.style.backgroundImage = "url('images/arrow_up_hover.png')";
	
	var voteNumberSpan = event.target.parentNode.getElementsByClassName("voteNumber")[0];
	var voteNumber = parseInt(voteNumberSpan.innerHTML);
	
	var dataVote = event.target.parentNode.getAttribute("data-vote");
	
	console.log("SENDING")
	webSocket.send(JSON.stringify({
	  requestType: "vote",
	  type: "Upvote"
	}));
	
	if (dataVote == "down") {
		event.target.parentNode.getElementsByClassName("downvoteArrow")[0].style.backgroundImage = "url('images/arrow_down.png')";
		event.target.parentNode.setAttribute("data-vote", "up");
		number = 2;
	} else if (dataVote == "up") {
		event.target.parentNode.getElementsByClassName("upvoteArrow")[0].style.backgroundImage = "url('images/arrow_up.png')";
		event.target.parentNode.setAttribute("data-vote", "none");
		number = -1;
	} else {
		number = 1;
		event.target.parentNode.setAttribute("data-vote", "up");
	}
	//voteNumberSpan.innerHTML = voteNumber + number;
	voteObject = voteNumberSpan;
	voteBuffer = voteNumber + number;
	
	
}
function downvoteArticle(event) {
	console.log("Downvote");
	event.target.style.backgroundImage = "url('images/arrow_down_hover.png')";
	
	var voteNumberSpan = event.target.parentNode.getElementsByClassName("voteNumber")[0];
	var voteNumber = parseInt(voteNumberSpan.innerHTML);
	
	var dataVote = event.target.parentNode.getAttribute("data-vote");
	
	console.log("SENDING")
	webSocket.send(JSON.stringify({
	  requestType: "vote",
	  type: "Downvote"
	}));
	
	if (dataVote == "up") {
		event.target.parentNode.getElementsByClassName("upvoteArrow")[0].style.backgroundImage = "url('images/arrow_up.png')";
		event.target.parentNode.setAttribute("data-vote", "down");
		number = -2;
	} else if (dataVote == "down") {
		event.target.parentNode.getElementsByClassName("downvoteArrow")[0].style.backgroundImage = "url('images/arrow_down.png')";
		event.target.parentNode.setAttribute("data-vote", "none");
		number = 1;
	} else {
		number = -1;
		event.target.parentNode.setAttribute("data-vote", "down");
	}
	//voteNumberSpan.innerHTML = voteNumber + number;
	voteObject = voteNumberSpan;
	voteBuffer = voteNumber + number;
}
