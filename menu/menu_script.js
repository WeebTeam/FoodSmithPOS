//id of modal (the background i guess, the shaded area when its enabled)
var modal = document.getElementById("modal");

// show modal of the respective form
function showModal(formID){
	var form = document.getElementById(formID);
	//id of modal contents
	var addCatModal = document.getElementById("modal-add-category");
	var addItemModal = document.getElementById("modal-add-item");
	var editCatModal = document.getElementById("modal-edit-category");
	var editItemModal = document.getElementById("modal-edit-item");
	var removeCatModal = document.getElementById("modal-delete-category");
	var removeItemModal = document.getElementById("modal-delete-item");
	
	//hide all forms
	addCatModal.style.display = "none";
	addItemModal.style.display = "none";
	editCatModal.style.display = "none";
	editItemModal.style.display = "none";
	removeCatModal.style.display = "none";
	removeItemModal.style.display = "none";
	
	//display both modal and selected form
	modal.style.display = "block";
	form.style.display = "block";
	
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
} 

function closeBtn(){
	//get the close button
	var closeBtn = document.getElementsByClassName("popup-close-btn");

	for(var i=0; i<closeBtn.length; i++){
	
	//when the close button is clicked, popup will be closed
	closeBtn[i].onclick = function(){
		modal.style.display = "none";
	}
	}
}

function showHideTable(table_index){
	var tableList = document.getElementsByClassName("theTables");
	
	if (tableList[table_index].style.display == "none"){
		tableList[table_index].style.display = "table";
	} else {
		tableList[table_index].style.display = "none";
	}
}

// Function to mark category for editing/deleting and fill it the modals
function categoryClicked(categoryName, categoryID){
	var catTitles = document.getElementsByClassName("catTitles");
	var selectedCat = document.getElementById(categoryName);
	
	var editCatButton = document.getElementById("edit-cat-btn");
	var deleteCatButton = document.getElementById("delete-cat-btn");
	
	var editCatForm = document.getElementById("form-edit-category");
	var deleteCatForm = document.getElementById("form-delete-category");
	
	for (var i = 0; i < catTitles.length; i++){
		catTitles[i].style.backgroundColor = "";
		catTitles[i].style.color = "black";
	}
	
	selectedCat.style.backgroundColor = "#87b5eb";
	selectedCat.style.color = "white";
	
	if (editCatButton.disabled){
		editCatButton.disabled = false;
		deleteCatButton.disabled = false;
	}
	
	editCatForm.elements.namedItem("edit_category").value = categoryID;
	editCatForm.elements.namedItem("categoryID").value = categoryID;
	editCatForm.elements.namedItem("categoryName").value = categoryName;
	
	deleteCatForm.elements.namedItem("delete_category").value = categoryID;
}

//Codes taken from : https://jsfiddle.net/armaandhir/Lgt1j68s/
function highlight_row() {
    var tableList = document.getElementsByClassName("theTables");
	
	var editItemButton = document.getElementById("edit-item-btn");
	var deleteItemButton = document.getElementById("delete-item-btn");
	
	for (var x = 0; x < tableList.length; x++)
	{
		var cells = tableList[x].getElementsByTagName("td");
		
		for (var i = 0; i < cells.length; i++) {
			
			var cell = cells[i];
			
			cell.onclick = function(){
				//enable buttons if disabled (first time only)
				if (editItemButton.disabled){
					editItemButton.disabled = false;
					deleteItemButton.disabled = false;
				}
				
				//Deselects all other rows
				for (var y = 0; y < tableList.length; y++)
				{
					var otherRows = tableList[y].getElementsByTagName("tr");
					for (var j = 0; j < otherRows.length; j++)
					{
						otherRows[j].classList.remove("selectedRow");
					}
				}
			
				// Sets clicked row with the class name
				var row = this.parentNode;
				row.className = "selectedRow";
				
				document.getElementById("form-edit-item").elements.namedItem("edit_item").value = row.childNodes[0].textContent;
				document.getElementById("form-edit-item").elements.namedItem("itemName").value = row.childNodes[0].textContent;
				document.getElementById("form-edit-item").elements.namedItem("itemPrice").value = row.childNodes[1].textContent;
				
				document.getElementById("form-delete-item").elements.namedItem("delete_item").value = row.childNodes[0].textContent;
			}
		}
	}
}

window.onload = init;

function init(){
	closeBtn()
	highlight_row()
}