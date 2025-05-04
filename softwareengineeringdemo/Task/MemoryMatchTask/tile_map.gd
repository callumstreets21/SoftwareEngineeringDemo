extends TileMap

var BoardSize = 4 ##board size on x and y
enum Layers{Hidden, Revealed} ##enum to switch a card between hidden and revealed
var SourceNumber = 0 ##what tileset we are using
const HiddenTileCoordinates = Vector2(13 , 0) ##what tile are we using to hide tiles
const HiddenTileAlternative = 1 ##which alternative tile is our hidden tile
var RevealedSpots = [] ##The spots that the player has revealed
var TilePositionToAtlasPosition = [] ##Where each card is mapped to atlas position
var Score = 0 ##Keeps track of the player score
var TurnsTaken = 0 ##Keeps track of the turns the player has taken

func GetTilesToUse(): ##gets the tiles to use
	var ChosenTileCoordinates = [] ##
	var Options = range(10) ##array of 0 through 9
	Options.Shuffle() ##shuffle arrays contents
	for i in range(board_size * int())
