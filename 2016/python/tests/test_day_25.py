from advent_of_code_2016.assembunny import AssemBunny

def test_out():
	ab = AssemBunny({'a': 10, 'b':3})
	signal = ab.out('out 5')

	assert signal == 5

	ab = AssemBunny({'a': 10, 'b':3})
	signal = ab.parse_instructions(['out a'])
	assert signal == [10]

	ab = AssemBunny({'a': 10, 'b':3})
	signal = ab.parse_instructions(['inc b', 'out b'])
	assert signal == [4]

	ab = AssemBunny({'a': 10, 'b':3})
	signal = ab.parse_instructions(['out b', 'inc b', 'out b'])
	assert signal == [3,4]