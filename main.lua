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
  local level_files = {}
  requireFiles(object_files)
  --same as above but for levels, this will have to go away eventually or it will load the whole game all at once and hold literally everything in memory
  recursiveEnumerate('levels', level_files)
  requireFiles(level_files)
  levels = {}
  current_level = TitleScreen
end

function love.update(dt)
  if current_level then current_level:update(dt) end
end

function love.draw()
  if current_level then current_level:draw() end
end

function addRoom(level_type, level_name, ...)
  local level = _G[level_type](level_name, ...)
  levels[level_name] = level
  return level
end

function gotoRoom(level_type, level_name, ...)
  if current_level and levels[level_name] then
      if current_level.deactivate then current_level:deactivate() end
      current_level = levels[level_name]
      if current_level.activate then current_level:activate() end
  else current_level = addRoom(level_type, level_name, ...) end
end
