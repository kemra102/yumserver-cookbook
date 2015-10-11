check : rubocop foodcritic

test : rubocop foodcritic kitchen

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
