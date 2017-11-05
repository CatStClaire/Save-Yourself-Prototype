Anim8 = require'libraries.anim8'
Input = require'libraries.Input'
Middleclass = require'libraries.middleclass'
Moan = require'libraries.moan.moan'
--recursive function that pulls in all of the files from a folder
function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end
--creates a require statement for every file found during recursiveEnumerate()
function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

function love.load()
  local object_files = {}
  --finds all the objects in the objects folder
  recursiveEnumerate('objects', object_files)
  --requires all the objects in the objects folder.
  --this will load everything in there for now but later we can separate out the objects into folders so that we load less all at once
  requireFiles(object_files)
end

function love.update(dt)

end

function love.draw()

end
