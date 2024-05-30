


window.addEventListener('message', function(event) {
    if (event.data.action === "display") {
        var data = event.data
        var treasure = document.getElementById("treasure-location");
        treasure.style.display = "block";
        const treasureDiv = document.createElement("div");
        treasure.innerHTML = ""

        treasureDiv.innerHTML = `
            <h1>Treasure Location</h1>
            <img class="treasure-img" src=${data.treasure.image} alt="Treasure Map">
            <button id="close-btn">Close</button>
        `;
        treasure.appendChild(treasureDiv);

        // Attach event listener to the close button
        document.getElementById('close-btn').addEventListener('click', function() {
            var treasure = document.getElementById("treasure-location");
            treasure.style.display = "none";
            // Send message to close the UI
            fetch(`https://${GetParentResourceName()}/lucid-treasure:close`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({
                    index: data.index,
                    location: data.treasure.location 
                })
            });

        });
    }
});