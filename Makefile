GOOGLE_CHROME := /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
MARKED := ./node_modules/.bin/marked
HTML := index.html
PDF := index.pdf

.DEFAULT_GOAL := $(PDF)

.PHONY:\
	clean

$(MARKED):
	npm install --save-dev marked

$(HTML): $(MARKED) index.md
	cat _header.html > $(HTML)
	$(MARKED) -i index.md >> $(HTML)
	cat _footer.html >> $(HTML)

$(PDF): $(HTML) style.css
	$(GOOGLE_CHROME) \
		--headless \
		--enable-logging \
		--log-level=1 \
		--disable-gpu \
		--crash-dumps-dir=/tmp \
		--disable-features=NetworkService \
		--print-to-pdf=$(PDF) \
		--print-to-pdf-no-header \
		$(HTML)

clean:
	rm -f $(HTML) $(PDF)
