function randomMissingPageText() {
    let randomTexts = [
        "The page you're looking for couldn't be found.",
        "The page vanished out of thin air.",
        "You have trapped yourself with a faulty link.",
        "The page was burned by the flames of the candle.",
        "The page was deleted by Monika.",
        "[object Object]",
        "Tom hasn't created the page yet."
    ];
    if (Math.random() < 0.7) return randomTexts[0];
    return randomTexts[Math.floor(Math.random() * (randomTexts.length))];
}

function replaceMissingPageText() {
    let elem = document.getElementById("mel.missing-no");
    if (elem == null || elem == undefined) return;
    elem.innerText = randomMissingPageText();
}