Vegan Drinks Database Builder
=============================

Barnivore is a site used by many vegans to check whether the a particular
alcoholic drink contains or is produced using any animal by-products.
You can use this library to build your own database of Barnivore's content
and keep it up to date with their changes.

The hope is to improve the accessibility to this data and encourage innovation
in the tough job of making this data as good as it possibly can be.

Uses Mechanize to do the web scraping.

MIT Licensed.

Company data
------------

For every company in the database, you'll get this data:

* Key-value pairs of the company's products and whether they're vegan. Format is: name => boolean
* An statement from the company (an email) saying which products are vegan.
* Company contact email address
* Company mailing address
* Company's site URL
* Company phone number
* The Barnivore URL of the company
* Informal name of the individual who first checked the data.
* Informal name of the individual who double-checked the data (if any)
* Rough date when added to Barnivore
* Rough date when updated on Barnivore
* Company fax number

Tests
-----

This tool is tested with RSpec2 and the sweet web mocking library VCR.

In the `spec/fixtures/vcr_cassettes` directory there are some .yml files
which VCR generated containing serialized HTTP responses from Barnivore.com.
If you delete the YAML files in that directory, VCR will allow web requests
to go out to the real site.

Coming Soon
-----------
* Support for importing this data in MongoDB.