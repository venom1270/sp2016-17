window.onload = function() {
	initVotingEventListeners();
}

function initVotingEventListeners() {
	var upvoteArrows = document.getElementsByClassName("upvoteArrow");
	for (var i = 0; i < upvoteArrows.length; i++) {
		upvoteArrows[i].addEventListener("click", upvoteArticle, event);
	}
	
	var downvoteArrows = document.getElementsByClassName("downvoteArrow");
	for (var i = 0; i < upvoteArrows.length; i++) {
		downvoteArrows[i].addEventListener("click", downvoteArticle, event);
	}
	
}

function upvoteArticle() {
	console.log("Upvote");
	event.target.style.backgroundImage = "url('images/arrow_up_hover.png')";
	
	var voteNumberSpan = event.target.parentNode.getElementsByClassName("voteNumber")[0];
	var voteNumber = parseInt(voteNumberSpan.innerHTML);
	
	var dataVote = event.target.parentNode.getAttribute("data-vote");
	
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
	voteNumberSpan.innerHTML = voteNumber + number;
	
	
}
function downvoteArticle() {
	console.log("Downvote");
	event.target.style.backgroundImage = "url('images/arrow_down_hover.png')";
	
	var voteNumberSpan = event.target.parentNode.getElementsByClassName("voteNumber")[0];
	var voteNumber = parseInt(voteNumberSpan.innerHTML);
	
	var dataVote = event.target.parentNode.getAttribute("data-vote");
	
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
	voteNumberSpan.innerHTML = voteNumber + number;
}
