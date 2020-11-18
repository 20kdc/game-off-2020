extends Node

const MODE_INGAME = preload("res://game/ingame.tscn")
const MODE_CUTSCENE = preload("res://cutscene/cutscene.tscn")

const SEQUENCE = [
	["intro", MODE_CUTSCENE, "Intro", "Introduction"],
	["tutorial", MODE_INGAME, "Tutorial", null],
	["tl1", MODE_CUTSCENE, "Welcome to Ascent Technologies", null],
	["levelA1", MODE_INGAME, "Splitting Hairs", "Learning To Aim High"],
	["levelA2", MODE_INGAME, "Skimming The Surface", null],
	["levelA3", MODE_INGAME, "A Flipping Perspective", null],
	["levelA4", MODE_INGAME, "But For A Pixel On A Screen", null],
	["tab", MODE_CUTSCENE, null, null],
	["levelB1", MODE_INGAME, "Acceleration", "Orchestra Of Dots"],
	["levelB2", MODE_INGAME, "Bureaucratic Space Partitioning", null],
	["levelB3", MODE_INGAME, "A Taste Of Things To Come", null],
	["levelB4", MODE_INGAME, "A Hopeful Dream", null],
	["turning_point_pre", MODE_CUTSCENE, "Turning Point", ""],
	["turning_point", MODE_INGAME, null, null],
	["turning_point_post", MODE_CUTSCENE, "Turning Point (Post)", null],
	["tl9", MODE_CUTSCENE, "Hello, Q1", null],
	["levelC1", MODE_INGAME, "Out 'n' Around", "Limited Resources"],
	["levelC2", MODE_INGAME, "Never Enough", null],
	["levelC3", MODE_INGAME, "All The Pieces Into Place", null],
	["levelC4", MODE_INGAME, "A Blind Fling", null],
	["nou_reveal", MODE_CUTSCENE, "The NoU", "Close To The Sun"],
	#["levelD1", MODE_INGAME, "And Then There Were Two (TBD)", "Close To The Sun"],
	#["levelD2", MODE_INGAME, "But Soon There Were Many (TBD)", null],
	#["levelD3", MODE_INGAME, "Their Heading Was Set (TBD)", null],
	["under_pressure", MODE_CUTSCENE, "A Point", null],
	["levelD4", MODE_INGAME, null, null],
	["endgame", MODE_CUTSCENE, "Goodbye", null]
]
