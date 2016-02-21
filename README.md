# Help Us
The most **important** part that we are missing is our **Artist** and **Designer**. If you can help us out, please send e-mail to [WWITDC@jdccn.ren](mailto:WWITDC@jdccn.ren)
Feel free to leave feedbacks on the project, our [website](wwitdc.jdnetwork.net), and the **translation**

---
# Regulation
- The default language for this project is **ENGLISH**. You can use Chinese, but it **must** have a translated version at the next line
- Have prefix of UC which stands for `Underchess`
- `<##>` is a Xcode mark, which places a place holder with the description text between `#`
- Every Scene should have a `UC<#Scene#>ViewController.swift` and a `UC<#Scene#>View.swift`
- Should use frameworks for interface like ones list below:
	- SpriteKit
	- SceneKit
	- Metal
	- GLKit
	- GamePlayKit
	- ReplyKit
	- ...
- Should save data frequently without influencing performance
- It is okay to use Objective-C **only if that's the only solution**
- **Last** sentence of **each** paragraph can end without period(`.`) in this project

# Use of storyboard
## LaunchScreen.storyboard 
**Critical: Do not make any changes to this file without posting the reason and tell the group members!**
## Main.sotryboard
1. Initial Scene is called `Splash`.
2. All other scenes should be present from **code**, **not segues** *(**only if it is necessary**)*

---
# Program Life Cycle
	Launch Screen
	Splash Scene
	If has endgame {
		Show Glance and Options 
		If Want to Pick Up{
			Go to Arena Scene
		} else {
			Go to Main Scene
		}
	} Else {
		Go to Main Scene
	}
	switch Main Scene{
		Case Go to Arena Scene:
			Choose Color for Pieces
			*Entering player's name if enable History*
			Display board
			Display Podium Scene
			Back to Main or Arena Scene
		Case Go to Settings Scene:
			Back to Main Scene
		Case Go to Game Center:
			TBC
	} 

---
# Plans on Scenes
- [ ] Splash
- [ ] Main
- [ ] Arena
- [ ] Podium
- [ ] Settings

# Plans on Functions
- [ ] Play with AI
- [ ] Use In 
- [ ] History of 
- [ ] Play with another player online


---
# Underchess
A board game that only have four pieces, and you have a lot of fun if you play it with **someone that has not play it before**.

# Introduction
`Board` `Strategy`
## How to play
Coming soon
## Tricks
Coming soon


---
# WWITDC
WWITDC is a student organization. We are all creative and good at something in different fields. We work as a group, the plans we come up, the decisions we make, the products we made, all of them are **TEAM WROK**. The world will see what we can make from our knowledge.

---
# The End
