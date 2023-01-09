var regex = new RegExp(/.*\d{4}(-\d{2}){2}_\d{2}(-\d{2}){2}\.jpg/, "i")
var bbva = []
var bancoppel = []

for (let file of listFiles("Pictures", false).split("\n")) {
  if (file.includes("Recibo")) {
    bancoppel.push(file)
  }
}

for (let file of listFiles("Documents", false).split("\n")) {
  if (file.match(regex)) {
    bbva.push(file)
  }
}
