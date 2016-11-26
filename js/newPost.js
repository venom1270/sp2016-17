window.onload = function() {
	
	fillCatogoryDiv();
	
}

function fillCatogoryDiv() {
	
	var catogoryDiv = document.getElementById("categoryDiv");
	categoryDiv.innerHTML = "";
	for (var t in tags) {
		
		categoryDiv.innerHTML += '<input type="checkbox" value="'+tags[t]+'"><span class="categoryTag">'+tags[t]+'</span></input>';
		
	}
	
}

