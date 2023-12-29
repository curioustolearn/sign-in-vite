global css 
	body 
		c:teal6 
		ff:Georgia 
		bgc: #f5f5f5
		fs: 1.2em
	button
		w: 100%
		c: white
		bgc: teal6
		border: none
		p: 12px
		fs: 0.9em
		rd: 5px
	button@disabled
		bgc: gray
		cursor:not-allowed
	input
		bd: none
		c: gray9
		bgc: inherit
		fs: 1.2em
		ff: Georgia 
	input@focus
		ol: none
	label
		d: block

def rndInt(min, max)
	min + Math.ceil(Math.random() * (max - min))

let signinInfo = {
	email: "",
	password: ""
	userans: ""
	correctans: 0
	enableSignIn: false
}

# draw random num1 and num2
let num1 = rndInt(1,100)
let num2 = rndInt(1,100)
# update correctans with randomly drawn numbers
signinInfo.correctans = num1 + num2;

###
Checks if signin button should be enabled.
###
def updateEnableSignIn
	let ansIsCorrect? = 
		signinInfo.correctans === parseInt(signinInfo.userans, 10)
	signinInfo.enableSignIn = 
		(signinInfo.password.length >= 7) and (signinInfo.email.includes('@')) and ansIsCorrect?

tag inputbox
	prop inputType
	prop labeltxt
	prop placeholder
	prop idval # for setting id of the input and `for` field in the label
	prop inFocus = false
	labelcolor = "gray5"
	bbc = "gray5"
	bbw = 1
	
	def triggerOnFocus(evt) 
		placeholder = ""
		inFocus = true
		bbw = 2
		bbc = "teal6"
		labelcolor = "teal6"

	def triggerOnBlur(evt) 
		console.log("val:", evt.target.value)
		inFocus = false
		if evt.target.value == ""
			placeholder = labeltxt
		labelcolor = "gray5"
		bbw = 1
		bbc = "gray5"
		console.log({signinInfo})


	# `data` in this function is a special imba variable that contains
	# and updates the value passed to this component.
	def render
		<self>
			<p>
				if inFocus or (data != "")
					<label[fs: 0.8em c:{labelcolor}] htmlFor=idval> 
						labeltxt
				<input[pt:0.5em w:100% pb:0.5em fs:1em bdb: solid {bbw}px {bbc}] 
						id=idval
						type=inputType 
						# size="50" 
						placeholder=placeholder 
						@focus=triggerOnFocus 
						@blur=triggerOnBlur 
						bind=data>


tag signin-btn
	css
		button@focus
			ol: none
	<self>
		<button disabled=!(signinInfo.enableSignIn)> "SUBMIT"


tag app

	<self>
		<div[w:100% 
		ml:auto
		mr:auto
		max-width:400px
		mt: 2em 
		bxs:xl
		p: 2em 2em]>
			<p[fs: 1.5em mb: 1em]>
				"Sign In"

			<inputbox[mb: 1.5em] bind=signinInfo.email 
			placeholder="Email" 
			labeltxt="Email" 
			idval="email"
			@keyup.debounce(300)=updateEnableSignIn
			inputType="text">

			<inputbox[mb: 1.5em] bind=signinInfo.password 
			placeholder="Password" 
			labeltxt="Password" 
			idval="password"
			@keyup.debounce(300)=updateEnableSignIn
			inputType="password">

			<inputbox[mb: 1.5em] bind=signinInfo.userans
			placeholder="What is {num1} + {num2}?" 
			labeltxt="What is {num1} + {num2}?" 
			idval="userans"
			@keyup.debounce(300)=updateEnableSignIn
			inputType="text">

			<signin-btn>

imba.mount do
	<app>
