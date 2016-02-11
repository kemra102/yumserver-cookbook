default : check kitchen

check : rubocop foodcritic

travis : check
	kitchen verify

rubocop :
	rubocop .

foodcritic :
	foodcritic -P -f any .

kitchen :
	kitchen test

.PHONY:
	travis test check rubocop foodcritic kitchen
