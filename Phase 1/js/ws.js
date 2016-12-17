var wsHost = "127.0.0.1:1234"; 
var webSocket;

document.addEventListener("DOMContentLoaded", function() {
	initWebSocket();
});


function initWebSocket() {
	webSocket = new WebSocket("ws://"+wsHost);
	webSocket.binaryType = 'arraybuffer';
	
	webSocket.addEventListener("message", wsResponseHandler);
	webSocket.addEventListener("error", wsResonseError);
	
	webSocket.onopen = function(event) {
		console.log("qwe");
		//webSocket.send("GANDLAF HERE!");
	}
	
}

function wsResponseHandler(event) {
	var response = event.data;
	if (response === "OKComment") {
		insertComment();
	} else if (response === "OKReply") {
		insertReply();
	} else if (response == "OKVote") {
		insertVote();
	}
}

function wsResonseError(event) {
	//document.getElementById("wsResult").innerHTML = "ERROR: Cannot connect to websocket server "+wsHost;
	console.log("ERROR");
}
function wsConnect(event) {
	//document.getElementById("wsResult").innerHTML = "ERROR: Cannot connect to websocket server "+wsHost;
	
}

