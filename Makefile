PYTHON ?= python3

.PHONY: check formula-check

check:
	$(PYTHON) -m unittest discover -s tests -v
	$(PYTHON) scripts/generate_formula.py --validate-if-present
	@if test -f Formula/geyser.rb; then ruby -c Formula/geyser.rb; fi

formula-check: check
	test -f Formula/geyser.rb
	brew audit --strict --online geyserlabs/tap/geyser
	brew test geyserlabs/tap/geyser
