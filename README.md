# Try it out at 
[https://appetize.io/app/9d73ftht6f0c736cfj15dne3aw](https://appetize.io/app/9d73ftht6f0c736cfj15dne3aw)

# Help Us
The ßmost **important** part that we are missing is our **Artist** and **Designer**. If you can help us out, please send e-mail to [info@wwitdc.com](mailto:info@wwitdc.com)
Feel free to leave feedbacks on the project, our [website](wwitdc.com), and the **translation**

## About commit
### For commit messages
There might be multiple points, so here is an example

	Explanation in the language you knows the best
	English Translation (If the one above is not in English)
	
	Explanation in the language you knows the best
	...

---
# Regulation
- The default language for this project is **ENGLISH**. You can use Chinese, but it **must** have a translated version at the next line
- Have prefix of UC which stands for `Underchess`
- `<##>` is a Xcode mark, which places a place holder with the description text between `#`
- Every Scene should have a `UC<#SceneName#>ViewController.swift` and a `UC<#SceneName#>View.swift`
- Use good names for **EVERYTHING**
	- Should 
		- Be descriptive, should be almost the same as reading an article that shows what it is about
	- Should ***NOT***
		- Be abbreviation, like "ULS" stands for "User Login Scene"
		- Be Chinese Pinyin, like "denglujiemian"
		- Be languages *OTHER* than English
- Common idioms
	- Don't merge so many sentence into one
- ...
- Unless SpriteKit gets to work, the project will use `CA` stuff instead of `SK`
- Should save data frequently without influencing performance
- It is okay to use Objective-C **only if that's the only solution**
- **Last** sentence of **each** paragraph can end without period(`.`) in this project

## Naming System for this project
	0---1
	|\ /|
	| 2 |
	|/ \|
	4   3

## Use of storyboard
### LaunchScreen.storyboard 
**Critical: Do not make any changes to this file without posting the reason and tell the group members!**
### Main.sotryboard
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
- [x] Splash
- [ ] Main
- [x] Arena
- [ ] Podium
- [ ] Settings

# Plans on Functions
- [ ] Play with AI
- [ ] Use In App Purchase
- [ ] History of Games
- [ ] Play with another player online

---
# Localization
## String
	func NSLocalizedString(
			// Identifier
		key: String,
			// Where to find the string
		tableName: String,
		bundle: NSBundle,
			// Value for string when it is not found
		value: String,
			// Instruction for translators
		comment: String
	) -> String
### Example
	let localString = NSLocalizedString(
		"Foo", 
		comment:"This string is shown when..."
	)
### Default
 `bundle` is `NSBundle.mainBundle()` and `tableName` is `Localizable`

## Formatted String
*Bad Example*
	let string = String.localizedSringWithFormat(
		NSLocalizedString(
			"Score is %f",
			comment:"Give the score"
		), 
		theNumber
	)

### Formatters
- Number
	- `let formatter = NSNumberFormatter()`
	- Displaying
	- `let stringWithFormatToDisplay = formatter.stringFromNumber()`
	- Parsing
	- ` formatter.numberStyle = <#NSNumberFormatterStyle#>
	let parsedNumber = formatter.numberFromString(<#userInputtedString#>)`
	- DecimalStyle ...
- Date
	- ShortStyle
	- MediumStyle
	- LongStyle
	- FullStyle
	- NoStyle
- ...
## Export
Editor --> Export For Localization

## Debug
`<#Target#>` --> Edit Scheme --> Duplicate --> Rename to `underchess <#language#>` --> Options --> Application Language

---
## Customized type 
**That can be stored in NSUserDefaults*
	struct Type{
		static/*Not sure is it is needed*/ let subType1 = <#AnyObject#> /*or other things*/
	}	

---
# Underchess
* `Board` `Strategy` *
A board game that only have four pieces, and you have a lot of fun if you play it with **someone that has not play it before**.

## Introduction
### How to play
Coming soon
### Tricks
Coming soon

---
# Used framework
For displaying notification: [LLDialog](https://github.com/LiulietLee/LLDialog/blob/master/LICENSE.txt)

---
# WWITDC
WWITDC is a student organization. We are all creative and good at something in different fields. We work as a group, the plans we come up, the decisions we make, the products we made, all of them are **TEAM WROK**. The world will see what we can make from our knowledge.

---
# The End
