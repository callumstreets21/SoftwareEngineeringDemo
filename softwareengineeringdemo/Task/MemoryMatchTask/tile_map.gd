extends TileMap

var BoardSize = 4 ##board size on x and y
enum Layers{Hidden, Revealed} ##enum to switch a card between hidden and revealed
var SourceNumber = 0 ##what tileset we are using
const HiddenTileCoordinates = Vector2(13 , 1) ##what tile are we using to hide tiles
const HiddenTileAlternative = 3 ##which alternative tile is our hidden tile
var RevealedSpots = [] ##The spots that the player has revealed
var TilePositionToAtlasPosition = {} ##Where each card is mapped to atlas position
var Score = 0 ##Keeps track of the player score
var TurnsTaken = 0 ##Keeps track of the turns the player has taken

func _ready() -> void:
	SetupBoard() ##at the start setup the board
	UpdateText() ##and update the text
	pass


func GetTilesToUse(): ##gets the tiles to use
	var ChosenTileCoordinates = [] ##
	var Options = range(10) ##array of 0 through 9
	Options.shuffle() ##shuffle arrays contents
	
	for i in range(BoardSize * int(BoardSize / 2)): ##range is the amount of unique cards needed
		var current = Vector2(Options.pop_back(), 1) ##popback gets the last num from shuffle as x, y is 1 (second row)
		for j in range(2):
			ChosenTileCoordinates.append(current) ##add two copies of the same card to the list
			
	ChosenTileCoordinates.shuffle() ##shuffle again so identical cards not next to eachother
	return ChosenTileCoordinates ##return the array with the picked cards
		
func SetupBoard():
	var CardsToUse = GetTilesToUse()
	for y in range(BoardSize): ##Gets x coord
		for x in range(BoardSize): ##Gets y coord
			var CurrentSpot = Vector2(x, y) ##goes through all the spots on the board
			PlaceCardFaceDown(CurrentSpot) ##passes Currentspot to PlaceCardFaceDown, places card at location
			var CardAtlasCoordinates = CardsToUse.pop_back() ##sets CardAtlasCoordinates to the last member of cards to use
			TilePositionToAtlasPosition[CurrentSpot] = CardAtlasCoordinates
			self.set_cell(Layers.Revealed, CurrentSpot, SourceNumber, CardAtlasCoordinates)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var GlobalClicked = event.position	##tells us where we clicked in the global space
			var PositionClicked = Vector2(local_to_map(to_local(GlobalClicked))) ##converts from global to local space 
			print(PositionClicked)	
			var CurrentTileAlternative = get_cell_alternative_tile(Layers.Hidden, PositionClicked) ##checks if its a hidden tile
			if CurrentTileAlternative == 1 and RevealedSpots.size() < 2: ##if its a hidden tile and less then 2 tiles are revealed
				self.set_cell(Layers.Hidden, PositionClicked, -1) ##set to no longer be hidden
				print("Placing tile at:", HiddenTileCoordinates)
				print("Placing tile at:", PositionClicked)
				RevealedSpots.append(PositionClicked) ##add the revealed tile to revealed spots
				if RevealedSpots.size() == 2:
					TwoCardsRevealed() ##if revealed 2 cards called TwoCardRevealed
	 		

func TwoCardsRevealed():
	if TilePositionToAtlasPosition[RevealedSpots[0]] == TilePositionToAtlasPosition[RevealedSpots[1]]: ##when the cards match
		Score += 1 ##add one to the score
		RevealedSpots.clear() ##clears the array
	else:
		PutBackCards() ##if the cards dont match
	
	TurnsTaken += 1 ##add one to turns taken
	UpdateText()		
		
func PutBackCards():
	await self.get_tree().create_timer(1.5).timeout ##set a timer of 1.5 seconds
	for Spot in RevealedSpots:
		PlaceCardFaceDown(Spot) ##for the cards in revealed spots, put them back face down
	RevealedSpots.clear() ##clear the RevealedSpots array
	
func UpdateText():
	$"../CanvasLayer/ScoreLabel".text = "Score: %d" % Score
	$"../CanvasLayer/TurnsLabel".text = "Turns taken: %d" % TurnsTaken
			

func PlaceCardFaceDown(coords: Vector2):
	self.set_cell(Layers.Hidden, coords, SourceNumber, HiddenTileCoordinates, HiddenTileAlternative)
	print("Placing tile at:", HiddenTileCoordinates)		
