// set timeout is a workaround, because we have yet to learn AJAX
setTimeout(function(){
    const closeButton = document.querySelector(".close-button");
    closeButton.addEventListener("click", () => {
    console.log("clicked")
    document.querySelector(".notice").classList.add("hidden");
})
}, 100);