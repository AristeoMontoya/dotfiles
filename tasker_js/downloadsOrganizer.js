const fsRoot = local('fsroot')
const directory = local('relativedestination')

function getFilesFromDir(dir) {
  var files = listFiles(dir, false).split('\n')

  return files
}

function sortFiles(files) {
  var sortedFiles = { }
  for (const file of files) {
    const separatedString = file.split('.')
    const extension = separatedString[separatedString.length - 1].toLowerCase()

    sortedFiles[extension] = sortedFiles[extension] || {}
    sortedFiles[extension]['files'] = sortedFiles[extension]['files'] || []
    sortedFiles[extension]['files'].push(file)
  }
  return sortedFiles
}

function moveFiles(files, origin) {
  for (const extension of Object.keys(files)) {
    const destination = `${fsRoot}/${origin}${extension}`
    createDir(destination, true, false)
    for (const fileName of files[extension].files) {
      shell(`mv "${fileName}" "${destination}"`, false, 10)
    }
  }
}

const files = getFilesFromDir(directory)
const sortedFiles = sortFiles(files)
moveFiles(sortedFiles, directory)
