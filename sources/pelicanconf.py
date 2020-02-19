#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Alice PELLET--MARY'
SITENAME = 'Alice PELLET--MARY'
SITEURL = 'http://perso.ens-lyon.fr/alice.pellet___mary'

PATH = 'content'

TIMEZONE = 'Europe/Paris'

DEFAULT_LANG = u'fr'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
RELATIVE_URLS = True
OUTPUT_PATH = '../'


THEME = "notmyidea"


DISPLAY_CATEGORIES_ON_MENU = False
DISPLAY_PAGES_ON_MENU = False

MENUITEMS = (
    ('Home', 'home.html'),
    ('Research', 'research.html'),
    ('Teaching', 'teaching.html'),
)

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
